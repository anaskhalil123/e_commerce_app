import 'package:e_commerce_app/screens/admin/admin_home_screen.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../widgets/AppIconWidget.dart';
import '../widgets/CustomTextField.dart';
import 'user/home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
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
              height: height * .1,
            ),
            CustomTextField(
              controller: nameController,
              icon: Icons.perm_identity,
              hint: 'Enter Full Name',
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              controller: emailController,
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
                  /* validate() method built the Form widget, with thr valiator method*/
                  if (_globalKey.currentState!.validate()) {
                    // do something
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      if (isTeacher) {
                        Navigator.pushNamed(context, AdminHome.id);
                      } else {
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                    }
                  }
                },
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
      ),
    );
  }
}
