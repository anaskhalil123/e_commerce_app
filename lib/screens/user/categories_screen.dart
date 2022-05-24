import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Product.dart';
import '../../models/purchase.dart';
import '../../provider/cartItem.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {

    List<Purchase> purchases = Provider
        .of<CartItem>(context)
        .purchase;

    return Container(
        child: Text(purchases.first.product.title)
    );
  }
}

