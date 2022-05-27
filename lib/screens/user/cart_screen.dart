import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../fireBase/firestore.dart';
import '../../models/OrderProduct.dart';
import '../../models/purchase.dart';
import '../../preferences/app_preferences.dart';
import '../../provider/cartItem.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers{
  @override
  Widget build(BuildContext context) {
    // List<Purchase> purchases = Provider.of<CartItem>(context).purchase;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // if (purchases.isNotEmpty) {
    return Container(
      color: Colors.grey.shade200,
      child: StreamBuilder<QuerySnapshot>(
          stream: FireStoreCotroller().readProductsInMyCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  itemBuilder: (context, index) {
                    return
                        // Card(
                        //   child:
                        Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: (7), horizontal: 7),

                              //  data[index].get('image') != "" ?
                              child: data[index].get('image') != ""
                                  ? Image.network(
                                      data[index].get('image'),

                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                              // value: loadingProgress.expectedTotalBytes != null
                                              //     ?
                                              //     loadingProgress.cumulativeBytesLoaded /
                                              //     loadingProgress.expectedTotalBytes!
                                              //     : null,
                                              ),
                                        );
                                      },

                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return
                                            //const Image(image: AssetImage('images/icons/placeholder.png',), fit:BoxFit.cover);
                                            Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/buy-it-73d4f.appspot.com/o/placeholder.png?alt=media&token=e0863ab9-be10-4ed8-8697-c5a9ca6b1746',
                                          fit: BoxFit.cover,
                                        );
                                      },

                                      // height: 120, width: 120
                                    )
                                  :
                                  //  const Image(image: AssetImage('images/placeholder.png',), fit:BoxFit.cover)
                                  Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/buy-it-73d4f.appspot.com/o/placeholder.png?alt=media&token=e0863ab9-be10-4ed8-8697-c5a9ca6b1746',
                                      fit: BoxFit.cover,
                                    ),

                              height: 120, width: 120,
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          alignment: AlignmentDirectional.topStart,
                          child: Column(
                            //    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
// mainAxisSize: MainAxisSize.max,

                            children: [
                              Container(
                                child: Text(
                                  data[index].get('title'),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                alignment: AlignmentDirectional.topStart,
                              ),
                              Container(
                                child: Text(
                                  data[index].get('price'),
                                  textAlign: TextAlign.center,
                                ),
                                margin: EdgeInsets.only(top: 5),
                                alignment: AlignmentDirectional.topStart,
                              ),
                              Container(
                                child: Text(
                                  '${data[index].get('quantity')}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red),
                                ),
                                margin: EdgeInsets.only(top: 5),
                                alignment: AlignmentDirectional.topStart,
                              )
                            ],
                          ),
                          width: width * 0.4 - 23,
                        ),
                        Container(
                          // child: Row(
                          //   children: [
                          child: data[index].get('isOrdered') == true?

                        Container(
                          child: DecoratedBox(
                    decoration: BoxDecoration(

                    color: Colors.amber,

                    borderRadius: BorderRadius.circular(20),
                    ),

                    child:TextButton(onPressed: () async{

                    }, child: Text('Wait Accept You Order',

                      style: TextStyle(fontSize: 12, color: Colors.white ,),textAlign: TextAlign.center, )

                    )
                    ),
                          height: 45,
                          width: 180,
                        ) :GestureDetector(
                              onTap: () async{

                                Purchase  purchase= Purchase(id: data[index].get('id'), title: data[index].get('title'),
                                    description: data[index].get('description'), price: data[index].get('price'),
                                    category: data[index].get('category'), image: data[index].get('image'), quantity: data[index].get('quantity'));

                                purchase.isOrdered =true;

                               String myId = AppPrefernces().myId.toString();
                                String myName = AppPrefernces().myName.toString();
                                String myImage = AppPrefernces().myImage.toString();

                                OrderProduct orderProduct = OrderProduct(id: data[index].get('id'), title: data[index].get('title'),
                                    description: data[index].get('description'), price: data[index].get('price'),
                                    category: data[index].get('category'), image: data[index].get('image'), quantity: data[index].get('quantity'), idOwnerOrder: myId,
                                    nameOwnerOrder: myName, imageOwnerOrder: myImage);
                                await addToOrders(orderProduct, data[index].id);
                                await isOrdered(data[index].id, purchase);


                              },

                              child: Image(
                            image: AssetImage('images/icons/buy.png'),
                          )),
                          // alignment: AlignmentDirectional.bottomEnd,

                          //   IconButton(
                          //     onPressed: () async {
                          //       // await delete(path: data[index].id);
                          //     },
                          //
                          //     icon: Icon(Icons.delete, color: Colors.red,),
                          //
                          //   )
                          //
                          // ],

                          //  verticalDirection: VerticalDirection.up,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.center,

                          margin: EdgeInsets.only(
                            top: 30,
                            right: 5,
                          ),
                          width: 120,
                          height: 100,
                          alignment: AlignmentDirectional.bottomEnd,
                        ),
                      ],

                      // )
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: data.length);
            } else {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    size: 85,
                    color: Colors.grey.shade500,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ));
            }
          }),
    );
  }


  Future<void> addToOrders(OrderProduct orderProduct, String path) async {
    bool status =
    await FireStoreCotroller().addToOrders(orderProduct: orderProduct, path: path);
    if (status) {
      showSnackBar(context: context, content: 'Ordered this product');
    }

  }


  Future<void> isOrdered(String id, Purchase purchase) async {
    bool status =
    await FireStoreCotroller().isOrdered(id: id, purchase: purchase);
    if (status) {
      showSnackBar(context: context, content: 'Ordered this product');
    }

  }


}
