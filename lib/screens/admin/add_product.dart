import 'dart:ffi';
import 'dart:io';

import 'package:e_commerce_app/fireBase/firestore.dart';
import 'package:e_commerce_app/fireBase/storage_controller.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:e_commerce_app/widgets/CustomTextField.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/Product.dart';

class AddProduct extends StatefulWidget{
  static String id = 'AddProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct>  with Helpers {
  late BuildContext _context;

  //using variables instead of controllers
  late String name, price, desc, category, location;

   var imageProduct;

  TextEditingController _titleTextController = TextEditingController();

  TextEditingController _descriptionTextController = TextEditingController();

  TextEditingController _categoryTextController = TextEditingController();

  TextEditingController _priceTextController = TextEditingController();

  TextEditingController _locationTextController = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

double? _indicatorValue = 0;

  XFile? _pickedFile;

ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'ADD PRODUCT',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: (height * 0.25)),
              child: Column(
                children: [
LinearProgressIndicator(
  value: _indicatorValue,
  backgroundColor: Colors.grey.shade500,
  color: Colors.green,
  minHeight: 5,

),

                 // Expanded(
                 //     child: Image
                 // ),
                 // Image(image: ImageIcon(Icons.image)),
                  CustomTextField(
                      controller: _titleTextController, hint: 'Product Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _priceTextController, hint: 'Product Price'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _descriptionTextController,
                      hint: 'Product Description'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _categoryTextController,
                      hint: 'Product Category'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _locationTextController,
                      hint: 'Product Location'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: _pickedFile != null
                    ?Image.file(File(_pickedFile!.path))
                    :TextButton(onPressed: () async{
                     await pickImage();
                    }, child: Text('PICK IMAGE'),
                    style: TextButton.styleFrom(minimumSize: Size(double.infinity, 50)),),
                  ),
                  /*
                  ElevatedButton(
                    child: Text('Add Image'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)
                    ),
                    onPressed: () async {
                Navigator.pushNamed(context, '/select_image_screen');

                    },
                  ),

*/
// Text('add image'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text('Add Product'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)
                    ),
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        print('data is validated');
                        _globalKey.currentState!.save();
                        await uploadImage();


                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> performSave() async {
    if (checkData()) {
      await save();

    }
  }

  bool checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _descriptionTextController.text.isNotEmpty &&
        _categoryTextController.text.isNotEmpty &&
        _priceTextController.text.isNotEmpty &&
        _locationTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: _context, content: 'Enter requred data', error: true);
    return false;
  }

  Future<void> save() async {
    bool status = await FireStoreCotroller().create(product: product);
    if (status) {
      showSnackBar(context: _context, content: 'product added successfully ');
      clear();
    }
  }

  Product get product {
    Product product = Product();
    product.title = _titleTextController.text;
    product.image = imageProduct.toString();
    product.price = _priceTextController.text;
    product.category = _categoryTextController.text;
    product.description = _descriptionTextController.text;
    product.location = _locationTextController.text;

    return product;
  }

  void clear() {
    _titleTextController.text = "";
    _descriptionTextController.text = "";
    _categoryTextController.text = "";
    _priceTextController.text = "";
    _locationTextController.text = "";
  }

  Future<void> pickImage() async{
  _pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  if(_pickedFile != null){
    setState(() {

    });
  }

  }


  Future<void> uploadImage() async{
    if(_pickedFile != null) {
      changeIndicatorValue(null);
   await  StorageController().uploadImage(file: File(_pickedFile!.path),
          eventHandler: (bool status, TaskState state, String message, {Reference? reference}) async {
            if (status) {
              //SUCCESS
           //   imageProduct = reference!.fullPath;

              imageProduct = reference?.fullPath;
             await performSave();
              changeIndicatorValue(1);
              showSnackBar(context: context, content: '$message \n $imageProduct', );
            } else {
              if (state == TaskState.running) {
                //UPLOADING
              //  showSnackBar(context: context, content: message);

                // changeIndicatorValue(1);
              } else {
                //FAILED
                changeIndicatorValue(0);
                showSnackBar(context: context, content: message, error: true);
              }
            }
          });
    }else{
      showSnackBar(context: context, content: 'Pick image to upload!', error: true);

    }
  }

  void changeIndicatorValue(double? newValue){
    setState(() {
      _indicatorValue = newValue;
    });
  }

}
