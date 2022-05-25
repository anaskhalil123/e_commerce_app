import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    List<Purchase> purchases = Provider.of<CartItem>(context).purchase;
    
    if (purchases.isNotEmpty) {

      return Text(purchases.first.product.title);

    } else {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.hourglass_empty),
              SizedBox(height: 10,),
              Text('Your Cart Does not Contain Any Products',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            ],
          ),
        );
    }
  }
}
