import 'package:flutter/cupertino.dart';

class SelectedCategory extends ChangeNotifier {
  var items = [
    'All',
    'Fashion',
    'Electrinics',
    'Computers',
    'Smart Home',
    'Arts & Cars',
    'Helth and Household',
    'Home and Kitchen',
    'Toys and Games',
    'Sports and Outdoors',
    'Baby',
    'Automotive',
    'Beauty and personal care'
  ];

  var items2 = [
    'Fashion',
    'Electrinics',
    'Computers',
    'Smart Home',
    'Arts & Cars',
    'Helth and Household',
    'Home and Kitchen',
    'Toys and Games',
    'Sports and Outdoors',
    'Baby',
    'Automotive',
    'Beauty and personal care'
  ];

  String category = "All";

  changeCategory(String value) {
    category = value;
    notifyListeners();
  }
}
