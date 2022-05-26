import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/fireBase/firestore.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Product_details.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with Helpers {
  int _tabBarIndex = 0;
  int allWidth = 0;
  String categ = 'Jackets';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    allWidth = width.toInt();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          onTap: (value) {
            setState(() {
              _tabBarIndex = value;
              switch (value) {
                case 0:
                  categ = 'Jackets';
                  break;
                case 1:
                  categ = 'T-shirts';
                  break;
                case 2:
                  categ = 'Trousers';
                  break;
                case 3:
                  categ = 'Shoes';
                  break;
              }
            });
            return;
          },
          tabs: const [
            Text(
              'Jackets',
              style: TextStyle(
                fontSize: 16,
                height: 2,
                color: Colors.blue,
              ),
            ),
            Text(
              'T-shirts',
              style: TextStyle(
                fontSize: 16,
                height: 2,
                color: Colors.blue,
              ),
            ),
            Text(
              'Trousers',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                height: 2,
              ),
            ),
            Text(
              'Shoes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                height: 2,
              ),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: FireStoreCotroller().read().asBroadcastStream(
                    onListen: (subscription) {
                  print('Listen now');
                }, onCancel: (subscription) {
                  print('canceled now');
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                    var newData = getProductsPerCategs(data, categ);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, ProductDetails.id,
                                    arguments: newData[index]);
                              },
                              child: Card(
                                color: kGrayColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image(
                                        fit: BoxFit.fill,
                                        height: 130,
                                        width: allWidth / 0.3,
                                        image:
                                            getImage(newData[index].get('image')),
                                        loadingBuilder: (BuildContext context,
                                            Widget widget,
                                            ImageChunkEvent? event) {
                                          if (event != null) {
                                            return const Center(
                                              heightFactor: 3.6,
                                              widthFactor: 5,
                                              child: CircularProgressIndicator(),
                                            );
                                          } else {
                                            return widget;
                                          }
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: Text(
                                          'Name: ${newData[index].get('title')}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          'desc: ${newData[index].get('description')}',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: newData.length,
                      ),
                    );
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
                })),
      ),
    );
  }

  Future<void> delete({required String path}) async {
    bool status = await FireStoreCotroller().delete(path: path);
    if (status) {
      showSnackBar(context: context, content: 'Product Deleted successfuly');
    }
  }

  ImageProvider getImage(String url) {
    if (url.isNotEmpty) {
      ImageProvider image = Image.network(url).image;
      print('My images now is ==>' + image.toString());
      return image;
    } else {
      return Image.asset('images/juckets/jacket07.jpeg').image;
    }
  }

  // Widget getProductsPerCateg(String category) {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: FireStoreCotroller()
  //           .readPerCategory(category)
  //           .asBroadcastStream(onListen: (subscription) {
  //         print('Listen now');
  //       }, onCancel: (subscription) {
  //         print('canceled now');
  //         FireStoreCotroller().readPerCategory(category).asBroadcastStream();
  //       }),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting &&
  //             snapshot.data == null) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
  //           List<QueryDocumentSnapshot> data = snapshot.data!.docs;
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 10),
  //             child: GridView.builder(
  //               scrollDirection: Axis.vertical,
  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2, childAspectRatio: 0.8),
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Navigator.pushNamed(context, ProductDetails.id,
  //                           arguments: data[index]);
  //                     },
  //                     child: Card(
  //                       color: kGrayColor,
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(20)),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Image(
  //                             fit: BoxFit.fill,
  //                             height: 130,
  //                             width: allWidth / 0.3,
  //                             image: getImage(data[index].get('image')),
  //                             loadingBuilder: (BuildContext context,
  //                                 Widget widget, ImageChunkEvent? event) {
  //                               if (event != null) {
  //                                 return const Center(
  //                                   heightFactor: 2,
  //                                   widthFactor: 5,
  //                                   child: CircularProgressIndicator(),
  //                                 );
  //                               } else {
  //                                 return widget;
  //                               }
  //                             },
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 horizontal: 8, vertical: 3),
  //                             child: Text(
  //                               'Name: ${data[index].get('title')}',
  //                               maxLines: 1,
  //                               overflow: TextOverflow.ellipsis,
  //                               style: const TextStyle(
  //                                   fontWeight: FontWeight.w600),
  //                               textAlign: TextAlign.right,
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 8),
  //                             child: Text(
  //                               'desc: ${data[index].get('description')}',
  //                               maxLines: 3,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //                 // ListTile(
  //                 //   leading: const Icon(Icons.title),
  //                 //   title: Text(data[index].get('title')),
  //                 //   subtitle: Text(data[index].get('description')),
  //                 //   trailing: IconButton(
  //                 //     onPressed: () {},
  //                 //     icon: const Icon(Icons.delete),
  //                 //   ),
  //                 // );
  //               },
  //               itemCount: data.length,
  //             ),
  //           );
  //
  //           /*ListView.separated(
  //                     itemBuilder: (context, index) {
  //                       return ListTile(
  //                         leading: const Icon(Icons.title),
  //                         title: Text(data[index].get('title')),
  //                         subtitle: Text(data[index].get('description')),
  //                         trailing: IconButton(
  //                             onPressed: () async {
  //                               await delete(path: data[index].id);
  //                             },
  //                             icon: const Icon(Icons.delete)),
  //                       );
  //                     },
  //                     separatorBuilder: (context, index) {
  //                       return Divider();
  //                     },
  //                     itemCount: data.length);*/
  //         } else {
  //           return Center(
  //               child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(
  //                 Icons.warning,
  //                 size: 85,
  //                 color: Colors.grey.shade500,
  //               ),
  //               Text(
  //                 'NO DATA',
  //                 style: TextStyle(
  //                     color: Colors.grey.shade500,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold),
  //               )
  //             ],
  //           ));
  //         }
  //       });
  // }

  List<QueryDocumentSnapshot<Object?>> getProductsPerCategs(
      List<QueryDocumentSnapshot<Object?>> data, String categ) {
    List<QueryDocumentSnapshot<Object?>> newData = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].get('category') == categ) {
        newData.add(data[i]);
      }
    }
    print('category is $categ');
    print('new data equal ${newData.length}');
    return newData;
  }
}
