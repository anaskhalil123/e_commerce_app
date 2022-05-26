import 'package:e_commerce_app/models/bn_screen.dart';
import 'package:e_commerce_app/screens/user/cart_screen.dart';
import 'package:e_commerce_app/screens/user/products_screen.dart';
import 'package:e_commerce_app/screens/user/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/selectedCategory.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  static bool productsScreenSetState = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>
with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  //int sizeItems = Provider.of<SelectedCategory>.items.length;

  final List<BnScreen> _screens = <BnScreen>[
    const BnScreen(title: 'HOME', widget: ProductsScreen()),
    const BnScreen(title: 'CATEGORIES', widget: CartScreen()),
    const BnScreen(title: 'PROFILE', widget: ProfileScreen())
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 13, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int sizeItems = Provider.of<SelectedCategory>(context).items.length;
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
//         bottom: _screens[_currentIndex].title == 'HOME'
//             ? TabBar(
//                 isScrollable: true,
//                 automaticIndicatorColorAdjustment: true,
//                 overlayColor: MaterialStateProperty.all(Colors.blue),
//                 controller: _tabController,
//                 labelColor: Colors.blue,
//                 labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                 unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
//                 indicatorWeight: 3,
//                 indicatorSize: TabBarIndicatorSize.tab,
// // indicatorPadding: EdgeInsets.only(left: 5),
//                 indicator: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blue, width: 1)),
//
//                 unselectedLabelColor: Colors.grey,
//
//                 onTap: (int selectedTabIndex) {
//                   setState(() {
//                     HomeScreen.productsScreenSetState = true;
//                     Provider.of<SelectedCategory>(context, listen: false)
//                         .changeCategory(Provider.of<SelectedCategory>(context,
//                                 listen: false)
//                             .items[selectedTabIndex]);
//                     print('Seleced Index: $selectedTabIndex');
//                   });
//                 },
//                 tabs: [
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[0],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[1],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[2],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[3],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[4],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[5],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[6],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[7],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[8],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[9],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[10],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[11],
//                   ),
//                   Tab(
//                     text: Provider.of<SelectedCategory>(context).items[12],
//                   )
//                 ],
//               )
//             : null,
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
}
