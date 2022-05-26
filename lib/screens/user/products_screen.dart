import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/fireBase/firestore.dart';
import 'package:e_commerce_app/screens/user/search_screen.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'Product_details.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
GestureDetector(
 onTap: (){
   Navigator.pushNamed(context, '/search_screen');
 },
  child:  Container(
  height: 45,
margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  child:   DecoratedBox(



    decoration: BoxDecoration(

      color: Colors.grey.shade100,



      borderRadius: BorderRadius.circular(20),

    ),

    //width: MediaQuery.of(context).size.width,



    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Row(

        children: [

          Expanded(child: Text('Search', style: TextStyle(color: Colors.black45),)),

          Icon(Icons.search, color: Colors.black45,)

        ],

      ),
    ),

  ),
),),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 132/214),

                    itemBuilder: (context, index) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  GestureDetector(
                            onTap: () {

                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails(product: getProduct(data[index]), path: data[index].id)
                                  // MaterialPageRoute(
                                  //     builder: (context) => ProductDetails( getProduct(data[index]), data[index].id))
                              //)
                              ));
                            },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,

                            children: [


                                // child:    Container(
                                //  margin: EdgeInsets.all(5),
                                //   height: 150,
                                //   color: Colors.grey.shade200,
                                //   padding: EdgeInsets.all(10),
                               // child:
                                DecoratedBox(

                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,

                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                //  color: kGrayColor,
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(15)),
                                  child:  Column(
                                    children: [
                                      Container(child: Icon(Icons.favorite, color: Colors.red, ),
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.all(5),
                                      ),
                                   Container(
height: 150,
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      data[index].get('image'),
                                      // height: 150,
                                      width: width / 0.3,
                                      loadingBuilder: (BuildContext context, Widget child,
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

                                      errorBuilder:
                                          (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return
                                          //const Image(image: AssetImage('images/icons/placeholder.png',), fit:BoxFit.cover);
                                          Image.network('https://firebasestorage.googleapis.com/v0/b/buy-it-73d4f.appspot.com/o/placeholder.png?alt=media&token=e0863ab9-be10-4ed8-8697-c5a9ca6b1746',
                                            fit:BoxFit.cover ,);
                                      },

                                      // height: 120, width: 120
                                    )
                                        // fit: BoxFit.fill,



                                  ),

                                ]

                                  )



                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Image(
                                //           fit: BoxFit.fill,
                                //           height: 120,
                                //           width: width / 0.3,
                                //           image: getImage(data[index].get('image'))),
                                //       Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 8, vertical: 3),
                                //         child: Text(
                                //           'Name: ${data[index].get('title')}',
                                //           maxLines: 1,
                                //           overflow: TextOverflow.ellipsis,
                                //           style: const TextStyle(
                                //               fontWeight: FontWeight.w600),
                                //           textAlign: TextAlign.right,
                                //         ),
                                //       ),
                                //       Padding(
                                //         padding:
                                //             const EdgeInsets.symmetric(horizontal: 8),
                                //         child: Text(
                                //           'desc: ${data[index].get('description')}',
                                //           maxLines: 3,
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                ),
                             // ),
                        //     ),
                        // ),
                      // Container(
                      //   child: Column(
                      //     children: [
                              Container(
margin: EdgeInsets.only(top: 10),

                                child: Column(children: [



                          Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    child: Container(
                                      height: 20,
                                      child: Text(
                                        'Name: ${data[index].get('title')}',
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
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                    child: Container(
                                      child: Text(
                                        'desc: ${data[index].get('description')}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                  ),

                                ],),
                              )
                          ],
                          )
                        ),
                      );

                      // ]
                      //   ),
                      // );
                      // ListTile(
                      //   leading: const Icon(Icons.title),
                      //   title: Text(data[index].get('title')),
                      //   subtitle: Text(data[index].get('description')),
                      //   trailing: IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(Icons.delete),
                      //   ),
                      // );
                    },
                    itemCount: data.length,
                  ),
                );

                /*ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.title),
                        title: Text(data[index].get('title')),
                        subtitle: Text(data[index].get('description')),
                        trailing: IconButton(
                            onPressed: () async {
                              await delete(path: data[index].id);
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: data.length);*/
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
    ]
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


  Product getProduct(QueryDocumentSnapshot snapshot){
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
