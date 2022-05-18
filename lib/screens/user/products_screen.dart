import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/fireBase/firestore.dart';
import 'package:e_commerce_app/utils/helpers.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FireStoreCotroller().read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.title),
                    title: Text(data[index].get('title')),
                    subtitle: Text(data[index].get('description')),
                    trailing: IconButton(
                        onPressed: () async{
                    await delete(path: data[index].id);
                    }, icon: Icon(Icons.delete)
                    ),

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
        });
  }

  Future<void> delete({required String path}) async{
   bool status = await FireStoreCotroller().delete(path: path);
   if(status){
     showSnackBar(context: context, content: 'Product Deleted successfuly');

   }
  }
}
