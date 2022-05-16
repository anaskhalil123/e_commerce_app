import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class CustomTextField extends StatelessWidget {
  late final String hint;
  late final IconData icon;
  late final TextEditingController controller;

  String? _errorMessage(String? str) {
    if (str!.isEmpty) {
      switch (hint) {
        case 'Enter Email':
          return 'Email is required';
        case 'Enter Password':
          return 'Password is required';
        case 'Enter Full Name':
          return 'Full Name is required';
      }
    } else {
      return null;
    }
  }

  CustomTextField({required this.icon, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        validator: _errorMessage,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: 'Enter Email',
          hintStyle: const TextStyle(color: Colors.black26),
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          filled: true,
          fillColor: kTextFieldColor,
        ),
      ),
    );
  }
}
