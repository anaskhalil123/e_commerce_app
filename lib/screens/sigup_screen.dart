
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../widgets/AppIconWidget.dart';
import '../widgets/CustomTextField.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {

  static String id = 'SignupScreen';

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
          CustomTextField(icon: Icons.perm_identity, hint: 'Enter Full Name'),
          SizedBox(
            height: height * .02,
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
                'Sign up',
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
                'Do have an account ?  ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              GestureDetector(
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}