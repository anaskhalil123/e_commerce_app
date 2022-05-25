import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/preferences/app_preferences.dart';
import 'package:e_commerce_app/provider/adminMode.dart';
import 'package:e_commerce_app/provider/cartItem.dart';
import 'package:e_commerce_app/provider/modelHud.dart';
import 'package:e_commerce_app/screens/admin/add_product.dart';
import 'package:e_commerce_app/screens/admin/admin_home_screen.dart';
import 'package:e_commerce_app/screens/image_selection_screen.dart';
import 'package:e_commerce_app/screens/launch_screen.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/sigup_screen.dart';
import 'package:e_commerce_app/screens/user/Product_details.dart';
import 'package:e_commerce_app/screens/user/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppPrefernces().initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),
        ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode()),
        ChangeNotifierProvider<CartItem>(create: (context) => CartItem())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //initialRoute: '/launch_screen',
         initialRoute: AdminHome.id,
        routes: {
          '/launch_screen': (context) => LaunchScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          ProductDetails.id: (context) => ProductDetails(),
          '/select_image_screen': (context) => SelectImageScreeen(),
        },
      ),
    );
  }
}
