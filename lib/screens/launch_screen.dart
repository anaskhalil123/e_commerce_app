import 'package:e_commerce_app/preferences/app_preferences.dart';
import 'package:e_commerce_app/screens/admin/admin_home_screen.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/user/home_screen.dart';
import 'package:e_commerce_app/widgets/AppIconWidget.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const  LaunchScreen  ({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State< LaunchScreen  > {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      String routIFActive = AppPrefernces().isTheacher ? AdminHome.id : HomeScreen.id;
      String rout = AppPrefernces().loggedIn ? routIFActive : LoginScreen.id;
      Navigator.pushReplacementNamed(context, rout);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppIconWidget(),
      ),
    );
  }
}
