import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/fireBase/firestore.dart';
import 'package:e_commerce_app/screens/sigup_screen.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:e_commerce_app/widgets/AppIconWidget.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../fireBase/auth.dart';
import '../models/UserModel.dart';
import '../provider/modelHud.dart';
import '../widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isTeacher = false;
  late String _email, _password;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: (50), horizontal: 20),
            children: [
              AppIconWidget(),
              SizedBox(
                height: height * .09,
              ),

              CustomTextField(

                controller: this.emailController,
                hint: 'Enter Email',
                icon: Icons.email,
                isNumber: false,

              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: passwordController,
                icon: Icons.lock,
                hint: 'Enter Password',
                isNumber: false,
              ),
              SizedBox(
                height: height * .01,
              ),
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
                    horizontal: (MediaQuery.of(context).size.width) * .20),

                child: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () async {
                      final modelHud =
                          Provider.of<ModelHud>(context, listen: false);
                      print('current state ${_globalKey.currentState}');
                      _globalKey.currentState?.validate();
                      // do something
                      _email = emailController.text.trim();
                      _password = passwordController.text.trim();
                      if (_email.isNotEmpty && _password.isNotEmpty) {
                        modelHud.changeIsLoading(true);

                        try {
                          final result = await _auth.signIn(_email, _password);

                          modelHud.changeIsLoading(false);
                          final snapshot = await FireStoreCotroller()
                              .getMyInformation(id: result.user!.uid);
                          Userm user = Userm(snapshot.id, snapshot.get('title'),
                              snapshot.get('email'), snapshot.get('isTeacher'));

                          //   showSnackBar(context: context, content: '$user');

                          // User user = User(email: _email, isTeacher: isTeacher);
                          // AppPrefernces().save(user: user);

                          // if (isTeacher) {
                          // Navigator.pushReplacementNamed(context, AdminHome.id);
                          // } else {
                          //    Navigator.pushReplacementNamed(context, HomeScreen.id);
                          // }
                        } catch (e) {
                          modelHud.changeIsLoading(false);
                          var indexStartMessage = e.toString().indexOf(' ', 0);
                          // Scaffold.of(context).showSnackBar(SnackBar(
                          //   content: Text(
                          //         '${e.toString().substring(indexStartMessage)}'
                          //
                          //   ),
                          // )
                          //
                          // );
                          showSnackBar(
                              context: context,
                              content:
                                  '${e.toString().substring(indexStartMessage)}',
                              error: true);
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
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
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
                      Navigator.pushReplacementNamed(context, SignupScreen.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
