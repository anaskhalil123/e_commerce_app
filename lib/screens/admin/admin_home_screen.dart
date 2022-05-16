import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/screens/admin/add_product.dart';
import 'package:e_commerce_app/screens/admin/edit_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static const String id = "AdminHome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: const Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProduct.id);
              },
              child: const Text('Edit Product'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('View Orders'),
            ),
          ],
        ),
      ),
    );
  }
}
