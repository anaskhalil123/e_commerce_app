import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fireBase/firestore.dart';
import '../../models/Product.dart';
import 'Product_details.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "SearchScreen";

  //const SearchScreen({Key? key}) : super(key: key);
  late TextEditingController? controller;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _titleTextController = TextEditingController();
  late TextForm tff;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    tff = TextForm(titleTextController: _titleTextController, focuse: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
        child: Column(
          children: [
            // Row(children:[const Icon(Icons.arrow_back_outlined)], ),
            Container(
              child: tff,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FireStoreCotroller().read(),
                  builder: (context, snapshot) {
                    if (_titleTextController.text.isEmpty) {
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

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot> data = snapshot.data!.docs;

                      List<QueryDocumentSnapshot> myData =
                          getProductsPerSearch(data, _titleTextController.text);

                      tff.focuse = false;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 132 / 214),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                                    product: getProduct(
                                                        myData[index]),
                                                    path: myData[index].id)));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(children: [
                                            Container(
                                              child: const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.all(5),
                                            ),
                                            Container(
                                                height: 150,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Image.network(
                                                  myData[index].get('image'),
                                                  // height: 150,
                                                  width: width / 0.3,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  },
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return
                                                        //const Image(image: AssetImage('images/icons/placeholder.png',), fit:BoxFit.cover);
                                                        Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/buy-it-73d4f.appspot.com/o/placeholder.png?alt=media&token=e0863ab9-be10-4ed8-8697-c5a9ca6b1746',
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                )),
                                          ])),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                              child: Container(
                                                height: 20,
                                                child: Text(
                                                  'Name: ${myData[index].get('title')}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  textAlign: TextAlign.right,
                                                ),
                                                alignment: Alignment.topLeft,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Container(
                                                child: Text(
                                                  'desc: ${myData[index].get('description')}',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                alignment: Alignment.topLeft,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                          itemCount: myData.length,
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
                  }),
            ),
          ],
        ),
      ),
    );
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
}

class TextForm extends StatefulWidget {
  TextForm({
    Key? key,
    required TextEditingController titleTextController,
    required this.focuse,
  })  : _titleTextController = titleTextController,
        super(key: key);

  final TextEditingController _titleTextController;
  bool focuse;

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.only(top: 10, right: 10),
      child: TextFormField(
        autofocus: widget.focuse,
        controller: widget._titleTextController,
        decoration: InputDecoration(
            icon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_outlined),
            ),
            suffixIcon: IconButton(
                alignment: Alignment.center,
                onPressed: () {
                  print('click');
                  setState(() {
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                icon: const Icon(Icons.search)),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.black26)),
      ),
    );
  }
}

List<QueryDocumentSnapshot> getProductsPerSearch(
    List<QueryDocumentSnapshot> data, String text) {
  List<QueryDocumentSnapshot> myData = [];
  if (text.isEmpty) {
  } else {
    for (int i = 0; i < data.length; i++) {
      if (data[i]
          .get('title')
          .toString()
          .toUpperCase()
          .contains(text.toUpperCase())) {
        myData.add(data[i]);
      }
    }
  }
  return myData;
}
