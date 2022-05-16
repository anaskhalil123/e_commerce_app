import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/screens/admin/admin_home_screen.dart';
import 'package:e_commerce_app/screens/sigup_screen.dart';
import 'package:e_commerce_app/widgets/AppIconWidget.dart';
import 'package:flutter/material.dart';

import '../widgets/CustomTextField.dart';
import 'user/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isTeacher = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            AppIconWidget(),
            SizedBox(
              height: height * .09,
            ),
            CustomTextField(
              controller: this.emailController,
              hint: 'Enter Email',
              icon: Icons.email,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              controller: passwordController,
              icon: Icons.lock,
              hint: 'Enter Password',
            ),
            SizedBox(
              height: height * .01,
            ),
            // TODO  isTeacher عشان نحفظ تعديل ال  provider  هنا نحتاج لل
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: [
                  Checkbox(
                    value: isTeacher,
                    activeColor: kTextFieldColor,
                    onChanged: (bool? value) {
                      setState(() {});
                      if (value != null) isTeacher = value;
                      print(isTeacher);
                      return;
                    },
                  ),
                  const Text(
                    'Admin (admin have a special features)',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width) * .31),
              child: ElevatedButton(
                onPressed: () {
                  print('current state ${_globalKey.currentState}');
                  _globalKey.currentState?.validate();
                  // do something
                  if (emailController.text != null &&
                      passwordController.text != null) {
                    if (isTeacher)
                      Navigator.pushNamed(context, AdminHome.id);
                    else
                      Navigator.pushNamed(context, HomeScreen.id);
                  }
                },
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
            ),
          ],
        ),
      ),
    );
  }
}
