import 'package:e_commerce_app/fireBase/auth.dart';
import 'package:e_commerce_app/fireBase/firestore.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/preferences/app_preferences.dart';
import 'package:e_commerce_app/provider/modelHud.dart';
import 'package:e_commerce_app/screens/admin/admin_home_screen.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../provider/adminMode.dart';
import '../widgets/AppIconWidget.dart';
import '../widgets/CustomTextField.dart';
import 'login_screen.dart';
import 'user/home_screen.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with Helpers {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  late String _name, _email, _password;

  final _auth = Auth();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isAdmin = false;

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
                height: height * .1,
              ),
              CustomTextField(
                controller: nameController,
                icon: Icons.perm_identity,
                hint: 'Enter Full Name',
                isNumber: false,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                controller: emailController,
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
                      value: Provider.of<AdminMode>(context).isAdmin,
                      activeColor: kTextFieldColor,
                      onChanged: (bool? value) {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(value!);

                        //  isAdmin =  Provider.of<AdminMode>(context, listen: true).isAdmin;
                        //  setState(() {});
                        if (value != null) isAdmin = value;

                        //   print(isAdmin);
                        //   return;
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

                      //modelHud.changeIsLoading(true);
                      print('current state ${_globalKey.currentState}');
                      /* validate() method built the Form widget, with thr valiator method*/
                      if (_globalKey.currentState!.validate()) {
                        // do something

                        _name = nameController.text;
                        _email = emailController.text.trim();
                        _password = passwordController.text.trim();
                        if (_name.isNotEmpty &&
                            _email.isNotEmpty &&
                            _password.isNotEmpty) {
                          modelHud.changeIsLoading(true);

                          try {
                            final result =
                                await _auth.signUp(_email, _password);
                            modelHud.changeIsLoading(false);
                            print(result.user!.uid);
                            print(result.user!.email);

                            // User user = User(id: result.user!.uid,name: _name, email: _email, isTeacher: isTeacher);
                            Userm user =
                                Userm(result.user!.uid, _name, _email, isAdmin);
                            AppPrefernces().save(user: user);
                            final storeUser = await FireStoreCotroller()
                                .storeUser(user: user);

                            if (isAdmin) {
                              Navigator.pushReplacementNamed(
                                  context, AdminHome.id);
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.id);
                            }
                          } catch (e) {
                            modelHud.changeIsLoading(false);
                            var indexStartMessage =
                                e.toString().indexOf(' ', 0);
                            //   Scaffold.of(context).showSnackBar(SnackBar(
                            //     content: Text(
                            // '${e.toString().substring(indexStartMessage)}'
                            //
                            //     ),
                            //   )
                            //   );
                            showSnackBar(
                                context: context,
                                content:
                                    '${e.toString().substring(indexStartMessage)}',
                                error: true);
                          }
                        } else {
                          print('no successful create account');
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
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
