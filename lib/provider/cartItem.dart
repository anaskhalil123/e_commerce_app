import 'package:e_commerce_app/models/purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Product.dart';

class CartItem extends ChangeNotifier {
  List<Purchase> purchase = [];

  addProduct(Product product, num number) {
    purchase.add(Purchase(product, number));
    print('add product: ${product.title}');
    notifyListeners();
  }
}
