import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/fireBase/firestore.dart';
import 'package:e_commerce_app/provider/selectedCategory.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Product.dart';
import 'Product_details.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with Helpers, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 13, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: TabBar(
        isScrollable: true,
        automaticIndicatorColorAdjustment: true,
        overlayColor: MaterialStateProperty.all(Colors.blue),
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 1)),
        unselectedLabelColor: Colors.grey,
        onTap: (int selectedTabIndex) {
          setState(() {
            Provider.of<SelectedCategory>(context, listen: false)
                .changeCategory(
                    Provider.of<SelectedCategory>(context, listen: false)
                        .items[selectedTabIndex]);
            print('Seleced Index: $selectedTabIndex');
          });
        },
        tabs: [
          Tab(
            text: Provider.of<SelectedCategory>(context).items[0],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[1],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[2],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[3],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[4],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[5],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[6],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[7],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[8],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[9],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[10],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[11],
          ),
          Tab(
            text: Provider.of<SelectedCategory>(context).items[12],
          )
        ],
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            // showSearch(context: context, delegate: DataSearch());
            Navigator.pushNamed(context, '/search_screen');
          },
          child: Container(
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),

              //width: MediaQuery.of(context).size.width,

              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  children: const [
                    Expanded(
                        child: Text(
                      'Search',
                      style: TextStyle(color: Colors.black45),
                    )),
                    Icon(
                      Icons.search,
                      color: Colors.black45,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: FireStoreCotroller().read(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<QueryDocumentSnapshot> data = snapshot.data!.docs;

                  List<QueryDocumentSnapshot> myData = getProductsPerCateg(
                      Provider.of<SelectedCategory>(context, listen: false)
                          .category,
                      data);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 132 / 214),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                            product: getProduct(myData[index]),
                                            path: data[index].id)));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
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
                                            padding: const EdgeInsets.all(10),
                                            child: Image.network(
                                              myData[index].get('image'),
                                              // height: 150,
                                              width: width / 0.3,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              errorBuilder:
                                                  (BuildContext context,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          child: Container(
                                            height: 20,
                                            child: Text(
                                              'Name: ${myData[index].get('title')}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.right,
                                            ),
                                            alignment: Alignment.topLeft,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                            child: Text(
                                              'desc: ${myData[index].get('description')}',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
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
      ]),
    );
  }

  Future<void> delete({required String path}) async {
    bool status = await FireStoreCotroller().delete(path: path);
    if (status) {
      showSnackBar(context: context, content: 'Product Deleted successfuly');
    }
  }

  ImageProvider getImage(String url) {
    if (Image.network(url).image is Uri) {
      ImageProvider image = Image.network(url).image;
      print('My images now is ==>' + image.toString());
      return image;
    } else {
      return Image.asset('images/juckets/jacket07.jpeg').image;
    }
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

  List<QueryDocumentSnapshot> getProductsPerCateg(
      String category, List<QueryDocumentSnapshot> data) {
    if (category != 'All') {
      List<QueryDocumentSnapshot> myData = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i].get('category') == category) {
          myData.add(data[i]);
          print(data[i].id);
        }
      }
      print('new data lenght is : ' + myData.length.toString());
      return myData;
    } else {
      return data;
    }
  }
}

// class DataSearch extends SearchDelegate<String>{
//   List<String> searchTerms;
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ();
//   }
//
// }