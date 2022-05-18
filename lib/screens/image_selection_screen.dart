import 'package:flutter/material.dart';

class SelectImageScreeen extends StatefulWidget {
  const SelectImageScreeen({Key? key}) : super(key: key);

  @override
  State<SelectImageScreeen> createState() => _SelectImageScreeenState();
}

class _SelectImageScreeenState extends State<SelectImageScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('PICK IMAGE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), ),

      ),
    );
  }
}

