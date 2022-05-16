import 'package:e_commerce_app/Constants.dart';
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
            SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Edit Product'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('View Orders'),
            ),
          ],
        ),
      ),
    );
  }
}
