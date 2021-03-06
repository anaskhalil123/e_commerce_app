import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/bn_screen.dart';
import 'package:e_commerce_app/preferences/app_preferences.dart';
import 'package:e_commerce_app/screens/user/cart_screen.dart';
import 'package:e_commerce_app/screens/user/products_screen.dart';
import 'package:e_commerce_app/screens/user/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fireBase/firestore.dart';
import '../../models/UserModel.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  static bool productsScreenSetState = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  //int sizeItems = Provider.of<SelectedCategory>.items.length;

  final List<BnScreen> _screens = <BnScreen>[
    const BnScreen(title: 'Home', widget: ProductsScreen()),
    const BnScreen(title: 'My Cart', widget: CartScreen()),
    const BnScreen(title: 'Profile', widget: ProfileScreen())
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int sizeItems = Provider.of<SelectedCategory>(context).items.length;

    getDataFromFirestoreToShared();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          _screens[_currentIndex].title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
        },
        currentIndex: _currentIndex,
        //fixedColor: Colors.amber,
        selectedItemColor: Colors.amber,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
      body: _screens[_currentIndex].widget,
    );
  }

  Future<void> getDataFromFirestoreToShared() async {
    AppPrefernces appPref = AppPrefernces();

    print('id == ' + appPref.myId);

    DocumentSnapshot<Map<String, dynamic>> userData =
        await FireStoreCotroller().getMyInformation(id: appPref.myId);

    print('writeAboutYourSelf == ' + userData.get('writeAboutYourSelf'));

    Userm user = Userm(
      userData.get('id'),
      userData.get('name'),
      userData.get('email'),
      userData.get('isAdmin'),
      userData.get('writeAboutYourSelf') ?? '',
      userData.get('imagePath') ?? '',
    );

    appPref.save(user: user);
  }
}
