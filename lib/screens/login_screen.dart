import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/screens/sigup_screen.dart';
import 'package:e_commerce_app/widgets/AppIconWidget.dart';
import 'package:flutter/material.dart';

import '../widgets/CustomTextField.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kMainColor,
      body: ListView(
        children: [
          AppIconWidget(),
          SizedBox(
            height: height * .1,
          ),
          CustomTextField(
            hint: 'Enter Email',
            icon: Icons.email,
          ),
          SizedBox(
            height: height * .02,
          ),
          CustomTextField(
            icon: Icons.lock,
            hint: 'Enter Password',
          ),
          SizedBox(
            height: height * .05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width) * .31),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(19),
                  primary: Colors.black),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Don\'t have an account ?  ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              GestureDetector(
                child: const Text(
                  'Signup',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SignupScreen.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
