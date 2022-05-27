

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fireBase/firestore.dart';



class OrdersScreen extends StatefulWidget {
  static String id = 'OrdersScreen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase orders'),

      ),

      body:  StreamBuilder<QuerySnapshot>(
            stream: FireStoreCotroller().readOrdersdProducts(),
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
                        Column(
                          children: [
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
                                      margin: EdgeInsets.only( left: 3),
                                      alignment: AlignmentDirectional.topStart,
                                    ),
                                    Container(
                                      child: Text(
                                        data[index].get('price'),
                                        textAlign: TextAlign.center,
                                      ),
                                      margin: EdgeInsets.only(top: 5, left: 3),
                                      alignment: AlignmentDirectional.topStart,
                                    ),
                                    Container(
                                      child: Text(
                                        '${data[index].get('quantity')}',
                                        textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.red)
                                      ),
                                      margin: EdgeInsets.only(top: 5, left: 3),
                                      alignment: AlignmentDirectional.topStart,
                                    )
                                  ],
                                ),
                                width: width * 0.4 - 23,
                              ),


                            ],

                          ),
                      Container(

                        width: width,
                        alignment: Alignment.bottomLeft,
                        child: Padding(

                        padding:
                        const EdgeInsets.only(top: 10, left: 25, bottom: 5),
                        child:   RichText(

                                text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),

                                    children: [
                                      TextSpan(
                                        text: 'Order From:',

                                      ),
                                      TextSpan(
                                        style: TextStyle(color: Colors.green,),
                                        text: """ ${data[index].get('nameOwnerOrder')}""",
                                      )

                                    ]),
                              ),
                        ),
                      ),

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: ElevatedButton(

                                child: Text('Accept Order'),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50)
                                ),
                                onPressed: () async {


await acceptOrder(path: data[index].id, idOwnerOrder :data[index].get('idOwnerOrder'));

                                },

                              ),
                            ),




                      ]
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
     // ),
    );
  }


  Future<void> acceptOrder({required String path, idOwnerOrder}) async {
    bool status = await FireStoreCotroller().acceptOrderDeleteFromOrder(path: path);
    bool status2 = await FireStoreCotroller().acceptOrderDeleteFromMyCart(path: path, idOwner: idOwnerOrder);
    if (status) {
      //showSnackBar(context: context, content: 'Product Deleted successfuly');
    }
  }
}
