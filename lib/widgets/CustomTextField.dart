import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class CustomTextField extends StatelessWidget {
  late final String hint;
  late final IconData? icon;
  late final TextEditingController? controller;

  late final isNumber;

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
      return '$hint is required';
    } else {
      return null;
    }
  }

  CustomTextField({this.icon, required this.hint, this.controller, required this.isNumber});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: hint =='Enter Password'? true: false,
        controller: controller,
        validator: _errorMessage,
        cursorColor: kMainColor,
      keyboardType: isNumber== true ? TextInputType.number : TextInputType.text,

        decoration: InputDecoration(
          hintText: hint,
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

    );
  }
}
