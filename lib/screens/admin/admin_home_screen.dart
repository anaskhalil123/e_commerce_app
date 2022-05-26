import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/screens/admin/edit_product.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fireBase/firestore.dart';
import 'add_product.dart';

class AdminHome extends StatefulWidget {
  static const String id = "AdminHome";

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with Helpers {
  @override
  // TODO: implement context
  BuildContext get context => super.context;
  late final ImageLoadingBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddProduct.id);
                      },
                      child: Icon(Icons.add),
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(80, 80)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const  Text(
                      'Add product',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Column(children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const  Icon(Icons.view_comfortable),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80)),
                    //_upload('camera')
                    // icon: const Icon(Icons.add),
                    // label: const Text('Add product')
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'View orders',
                    style: TextStyle(fontSize: 12),
                  )
                ])
              ]),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FireStoreCotroller().read(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                        return ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            itemBuilder: (context, index) {
                              if (data[index]
                                  .get('image')
                                  .toString()
                                  .isNotEmpty) {
                              } else {}

                              return Card(
                                  child: Row(
                                children: [
                                  Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),

                                            //  data[index].get('image') != "" ?
                                            child: data[index].get('image') !=
                                                    ""
                                                ? Image.network(
                                                    data[index].get('image'),
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
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

                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
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
                                                  )),
                                        height: 120,
                                        width: 120,
                                      )),
                                  Column(
                                    children: [
                                      Text(data[index].get('title')),
                                      Text(data[index].get('price'))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProduct(getProduct(
                                                            data[index]))));
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () async {
                                            await delete(path: data[index].id);
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  )
                                ],
                              ));
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
                            ElevatedButton(
                              //
                              onPressed: () {
                                Navigator.pushNamed(context, AddProduct.id);
                              },
                              child: const Text('Add Product'),
                            ),
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
              )
            ],
          ),
        ));
  }

  Product getProduct(QueryDocumentSnapshot snapshot) {
    Product product = Product();
    product.path = snapshot.id;
    product.title = snapshot.get('title');
    product.description = snapshot.get('description');
    product.category = snapshot.get('category');
    product.price = snapshot.get('price');
    product.image = snapshot.get('image');

    return product;
  }

  Future<void> delete({required String path}) async {
    bool status = await FireStoreCotroller().delete(path: path);
    if (status) {
      showSnackBar(context: context, content: 'Product Deleted successfuly');
    }
  }
}
