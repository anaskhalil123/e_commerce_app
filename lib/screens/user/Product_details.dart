import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/models/purchase.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fireBase/firestore.dart';

class ProductDetails extends StatefulWidget {
  static String id = 'ProductDetails';
  final Product? product;
  final String? path;

  ProductDetails({required this.product, required this.path});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with Helpers {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    // DocumentSnapshot? product =
    //     ModalRoute.of(context)!.settings.arguments as DocumentSnapshot?;
    // String url = product!.get('image');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //
      // ),
      body: Stack(
        children: [
          Container(
            color: Colors.lightBlue.shade100,
            margin: EdgeInsets.only(top: 31),
            child: Image.network(
              widget.product!.image,
            ),
            alignment: Alignment.topCenter,
            height: 300,
          ),
          // Image(
          //   alignment: Alignment.topCenter,
          //   image: Image.network(url).image,
          //   height: 220,
          // ),
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
                              text: '   ${widget.product!.title}',
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
                              text: '   ${widget.product!.category}',
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
                              text: '   ${widget.product!.price}',
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
                        _quantity.toString(),
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Total:',
                            ),
                            TextSpan(
                              style: TextStyle(color: Colors.red),
                              text:
                                  """ ${int.parse(widget.product!.price) * _quantity} \$""",
                            )
                          ]),
                    ),
                  ),
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
                onPressed: () async {
                  Purchase purchase = Purchase(
                      id: widget.path.toString(),
                      title: widget.product!.title,
                      description: widget.product!.description,
                      price: '${int.parse(widget.product!.price) * _quantity}',
                      category: widget.product!.category,
                      image: widget.product!.image,
                      quantity: _quantity);
                  await addToCart(purchase);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addToCart(Purchase purchase) async {
    bool status = await FireStoreCotroller().addToCart(purchase: purchase);
    if (status) {
      showSnackBar(context: context, content: 'Added to Cart');
    }
  }

  subTractCount() {
    if (_quantity > 1) {
      setState(() {
        _quantity -= 1;
      });
    }
  }

  addCount() {
    setState(() {
      _quantity += 1;
    });
  }
}
