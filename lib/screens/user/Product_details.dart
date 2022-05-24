import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cartItem.dart';

class ProductDetails extends StatefulWidget {
  static String id = 'ProductDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with Helpers{
  num _quantaty = 1;

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot? product =
        ModalRoute.of(context)!.settings.arguments as DocumentSnapshot?;
    String url = product!.get('image');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            alignment: Alignment.topCenter,
            image: Image.network(url).image,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, height * 0.05, 20, 0),
              child: Container(
                alignment: Alignment.topCenter,
                height: height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: height * 0.37),
              height: height * 0.453,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          children: [
                            const WidgetSpan(
                              child: Icon(Icons.title),
                            ),
                            TextSpan(
                              text: '   ${product.get('title')}',
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          children: [
                            const WidgetSpan(
                              child: Icon(Icons.category),
                            ),
                            TextSpan(
                              text: '   ${product.get('description')}',
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          children: [
                            const WidgetSpan(
                              child: Icon(Icons.price_change),
                            ),
                            TextSpan(
                              text: '   ${product.get('price')}',
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      const Text(
                        'Count: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: width * 0.02),
                      ClipOval(
                        child: Material(
                          color: Colors.blue,
                          child: GestureDetector(
                              onTap: addCount,
                              child: const SizedBox(
                                height: 28,
                                width: 28,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _quantaty.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Material(
                          color: Colors.blue,
                          child: GestureDetector(
                              onTap: subTractCount,
                              child: const SizedBox(
                                height: 28,
                                width: 28,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            width: width,
            height: 60,
            child: Builder(
              builder: (context) => MaterialButton(
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Text(
                  'Add To Cart'.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  //car item
                  CartItem cartItem =
                      Provider.of<CartItem>(context, listen: false);
                  // get product from map
                  Map<String, dynamic> map = Map();
                  map['title'] = product.get('title');
                  map['description'] = product.get('description');
                  map['image'] = product.get('image');
                  map['price'] = product.get('price');
                  map['category'] = product.get('category');
                  // TODO Location will ber removed
                  map['location'] = product.get('location');
                  print(map.toString());

                  // add product to product in cart
                  cartItem.addProduct(Product.fromMap(map), _quantaty);

                  showSnackBar(context: context, content: 'Added to Cart');
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  subTractCount() {
    if (_quantaty > 1) {
      setState(() {
        _quantaty -= 1;
      });
    }
  }

  addCount() {
    setState(() {
      _quantaty += 1;
    });
  }
}
