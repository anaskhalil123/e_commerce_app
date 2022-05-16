
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class CustomTextField extends StatelessWidget {

  late final String hint;
  late final IconData icon;

  CustomTextField({required this.icon ,required this.hint });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
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
          filled: true,
          fillColor: kTextFieldColor,
        ),
      ),
    );
  }
}
