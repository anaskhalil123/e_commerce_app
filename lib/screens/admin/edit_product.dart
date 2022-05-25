import 'dart:io';

import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/screens/admin/add_product.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../fireBase/firestore.dart';
import '../../fireBase/storage_controller.dart';
import '../../widgets/CustomTextField.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';
 final Product? product;

  EditProduct(this.product);


  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> with Helpers{


  // final List<ProductIner> _products = [
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket06.jpeg'),
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket01.jpeg'),
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket02.jpeg'),
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket04.jpeg'),
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket05.jpeg'),
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket08.jpeg'),
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket07.jpeg'),
  //   ProductIner('jacket', '30', 'Jackets', "jacker desc......",
  //       'images/juckets/jacket01.jpeg')
  // ];
  
  
  var imageProduct;

  late TextEditingController _titleTextController;
  late TextEditingController _descriptionTextController;
  late TextEditingController _categoryTextController;
  late TextEditingController _priceTextController;
  late TextEditingController _locationTextController;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  double? _indicatorValue = 0;

  XFile? _pickedFile;
  ImagePicker imagePicker = ImagePicker();


  @override
  void initState(){
    super.initState();
  //  getProducts();
    _titleTextController = TextEditingController(text: widget.product?.title ?? '');
    _descriptionTextController = TextEditingController(text: widget.product?.description ?? '');
    _categoryTextController = TextEditingController(text: widget.product?.category ?? '');
    _priceTextController = TextEditingController(text: widget.product?.price ?? '');

  }

@override
void dispose() {
  _titleTextController.dispose();
  _descriptionTextController.dispose();
  _categoryTextController.dispose();
  _priceTextController.dispose();
  _locationTextController.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    
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
                            height: 30,
                          ),
                          Container(

                            child: _pickedFile != null
                                ?Image.file(File(_pickedFile!.path))
                                :TextButton(onPressed: () async{
                              await pickImage();
                            }, child: Text('PICK IMAGE'),
                              style: TextButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.amber.shade100),),
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
                            child: Text('Edit Product'),
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
                  ]
              ),
            ),
          ),
        ));
      
      /*
      GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: .8,
          ),
          itemBuilder: (context, index) => GestureDetector(
                onTapUp: (details) {
                  // position in x axis
                  double dx = details.globalPosition.dx;
                  double dy = details.globalPosition.dy;
                  // distance between the item and the right side of the mobile (المسافة التي يبعد عنها العنصر بالنسبة ليمين الحوال)
                  double dx2 = (MediaQuery.of(context).size.width) - dx;
                  double dy2 = (MediaQuery.of(context).size.height) - dy;

                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                      items: [
                        PopupMenuItem(child: Text('Edit')),
                        PopupMenuItem(child: Text('Delete')),
                      ]);
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(_products[index].imageLocation),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_products[index].name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('\$ ${_products[index].price}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          itemCount: _products.length),
      
      
      
      */
   // );
  }

  // @override
  // void initState() {
  //
  //   super.initState();
  // }

  //void getProducts() {}

  Future<void> performSave() async {
    if (checkData()) {
      await update();
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
    showSnackBar(context: context, content: 'Enter requred data', error: true);
    return false;
  }

  Future<void> update() async {
    bool status = await FireStoreCotroller().update(path: widget.product!.path, product: product);
    if (status) {
      showSnackBar(context: context, content: 'product Edited successfully ');
      Navigator.pop(context);
    }
  }

  Product get product {
    Product product = Product();
    product.title = _titleTextController.text;
    product.image = imageProduct;
    product.price = _priceTextController.text;
    product.category = _categoryTextController.text;
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

              imageProduct = reference!;
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




// class ProductIner {
//   late String name;
//   late String price;
//   late String desc;
//   late String category;
//   late String imageLocation;
//
//   ProductIner(this.name, this.price, this.category, this.desc, this.imageLocation);
// }
