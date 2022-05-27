import 'dart:io';

import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/screens/admin/add_product.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../fireBase/firestore.dart';
import '../../fireBase/storage_controller.dart';
import '../../provider/selectedCategory.dart';
import '../../widgets/CustomTextField.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';
 final Product? product;

  EditProduct(this.product);


  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> with Helpers{


  
  String imageProduct = "";

  late TextEditingController _titleTextController;
  late TextEditingController _descriptionTextController;
  late TextEditingController _priceTextController;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  double? _indicatorValue = 0;

  XFile? _pickedFile;
  ImagePicker imagePicker = ImagePicker();

  String category = '';


 late String categoryOfProduct;
 bool isChange = false;


  @override
  void initState(){
    super.initState();
  //  getProducts();
    categoryOfProduct = widget.product!.category;
    _titleTextController = TextEditingController(text: widget.product?.title ?? '');
    _descriptionTextController = TextEditingController(text: widget.product?.description ?? '');
    _priceTextController = TextEditingController(text: widget.product?.price ?? '');
    imageProduct = widget.product?.image ?? '';


  }

@override
void dispose() {
  _titleTextController.dispose();
  _descriptionTextController.dispose();
  _priceTextController.dispose();


    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Provider.of<SelectedCategory>(context).category =product!.category;
     category = Provider.of<SelectedCategory>(context).category;
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Edit product',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: _globalKey,
          child: Container(
            height: height,

            width: width,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _indicatorValue,
                      backgroundColor: Colors.grey.shade500,
                      color: Colors.green,
                      minHeight: 5,

                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: (50), horizontal: 20),
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _titleTextController, hint: 'Product Name', isNumber: false,),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _descriptionTextController,
                            hint: 'Product Description', isNumber: false,),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: _priceTextController, hint: 'Product Price', isNumber: true,),

                          const SizedBox(
                            height: 10,
                          ),


                          Container(
                            width: width,
                            height: 55,



                            child:
                            DecoratedBox(

                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,

                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: DropdownButton(

                                isExpanded: true,

                                // Initial Value
                                value: isChange == false ? categoryOfProduct : Provider.of<SelectedCategory>(context).category,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: Provider.of<SelectedCategory>(context).items2.map((String items) {


                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  Provider.of<SelectedCategory>(context, listen: false).changeCategory(newValue!);
                                  category = newValue;
                                  isChange = true;
                                  // setState(() {
                                  //   dropdownvalue = newValue!;
                                  // });
                                },


                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          GestureDetector(
                            onTap: () async{
                              await pickImage();
                            },

                            child: _pickedFile != null
                                ?Image.file(File(_pickedFile!.path), height: 220)
                                : Image.network(product.image, height: 220,
                              errorBuilder:
                                  (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return
                                  //const Image(image: AssetImage('images/icons/placeholder.png',), fit:BoxFit.cover);
                                  Image.network('https://firebasestorage.googleapis.com/v0/b/buy-it-73d4f.appspot.com/o/placeholder.png?alt=media&token=e0863ab9-be10-4ed8-8697-c5a9ca6b1746',
                                    fit:BoxFit.cover ,);
                              },
                            )

                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            child: Text('Edit Product'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50)
                            ),
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                print('data is validated');
                                _globalKey.currentState!.save();
                                await performSave();


                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ));

  }

  Future<void> performSave() async {
    if (checkData()) {
      if(_pickedFile != null){
        await uploadImage();
      }else{
        await update();
        changeIndicatorValue(null);
      }


    }
  }

  bool checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _descriptionTextController.text.isNotEmpty &&
        _priceTextController.text.isNotEmpty
        && imageProduct != "" && category.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter requred data', error: true);
    return false;
  }

  Future<void> update() async {
    bool status = await FireStoreCotroller().update(path: widget.product!.path, product: product);
    if (status) {
      changeIndicatorValue(1);
      showSnackBar(context: context, content: 'product Edited successfully ');
      Navigator.pop(context);
    }
  }

  Product get product {
    Product product = Product();
    product.title = _titleTextController.text;
    product.image = imageProduct;
    product.price = _priceTextController.text;
    product.category = category;
    product.description = _descriptionTextController.text;


    return product;
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

              imageProduct = await reference!.getDownloadURL();
              await update();
              changeIndicatorValue(1);

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

