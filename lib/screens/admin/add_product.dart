import 'package:e_commerce_app/widgets/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';

  //using variables instead of controllers
  late String name, price, desc, category, location;

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  CustomTextField(hint: 'Product Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(hint: 'Product Price'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(hint: 'Product Description'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(hint: 'Product Category'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(hint: 'Product Location'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text('Add Product'),
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        print('data is validated');
                        _globalKey.currentState!.save();
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
}
