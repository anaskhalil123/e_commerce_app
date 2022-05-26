import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (purchases.isNotEmpty) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: purchases.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kBlueColor,
                      ),
                      height: height * .15,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                radius: height * .15 / 3,
                                backgroundImage: Image.network(
                                        purchases[index].product.image)
                                    .image),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    purchases[index].product.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '\$ ' +
                                    (int.parse(purchases[index].product.price) +
                                            purchases[index].number)
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              purchases[index].number > 1
                                  ? '${purchases[index].number} items'
                                  : '1 item',
                              textAlign: TextAlign.end,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          MaterialButton(
              padding: const EdgeInsets.all(12),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Colors.blue,
              minWidth: width * 0.98,
              onPressed: () {},
              child: const Text(
                'Order',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ],
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.hourglass_empty),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Cart Does not Contain Any Products',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }
  }
}

/*
* Card(
              child: Container(
                width: width / 0.1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: height / 0.1,
                          backgroundImage:
                              Image.network(purchases[index].product.image)
                                  .image),
                      Column(
                        children: [
                          Text(
                              '${purchases[index].number} ${purchases[index].product.title}'),
                          Text(
                              ' \$  ${purchases[index].product.price * purchases[index].number}'),
                        ],
                      ),
                    ]),
              ),
            );*/
