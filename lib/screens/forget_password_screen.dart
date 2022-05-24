import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/screens/admin/admin_home_screen.dart';
import 'package:e_commerce_app/screens/sigup_screen.dart';
import 'package:e_commerce_app/widgets/AppIconWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fireBase/auth.dart';
import '../models/User.dart';
import '../provider/modelHud.dart';
import '../widgets/CustomTextField.dart';
import 'user/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class ForgetPasswordScreen extends StatefulWidget {
  static String id = 'ForgetPasswordScreen';

  @override
  State<ForgetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
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
            children: [
              Text('Forget password...'),
              AppIconWidget(),
              SizedBox(
                height: height * .09,
              ),
              CustomTextField(
                controller: this.emailController,
                hint: 'Enter Email to recevive reset link',
                icon: Icons.email,
              ),

              SizedBox(
                height: height * .03,
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: Size(double.infinity, 50),
              //     shadowColor: Row
              //   ),
              //     onPressed: onPressed, child: child
              // ),
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
      ),
    );
  }
}
