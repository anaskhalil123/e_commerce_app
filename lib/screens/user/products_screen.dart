import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Constants.dart';
import 'package:e_commerce_app/fireBase/firestore.dart';
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

    return StreamBuilder<QuerySnapshot>(
        stream: FireStoreCotroller().read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetails.id,
                            arguments: data[index]);
                      },
                      child: Card(
                        color: kGrayColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                fit: BoxFit.fill,
                                height: 120,
                                width: width / 0.3,
                                image: getImage(data[index].get('image'))),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              child: Text(
                                'Name: ${data[index].get('title')}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'desc: ${data[index].get('description')}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
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
        });
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
}
