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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
      ),

      /*
      StreamBuilder<QuerySnapshot>(
        stream: FireStoreCotroller().read(),
       */

      body: StreamBuilder<QuerySnapshot>(
          stream: FireStoreCotroller().read(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          onPressed: (){} , //_upload('camera')
                          icon: const Icon(Icons.camera),
                          label: const Text('camera')),
                      ElevatedButton.icon(
                          onPressed: () {}, //=> _upload('gallery')
                          icon: const Icon(Icons.library_add),
                          label: const Text('Gallery')),
                    ],
                  ),
                  Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(child: ListTile(
                    //  leading: Image.network('dddd'),
                      // leading: Icon(Icons.title),
                      title: Text(data[index].get('title')),
                      subtitle: Text(data[index].get('price')),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProduct(getProduct(data[index]))));
                      },
                      trailing: IconButton(
                          onPressed: () async {
                            await delete(path: data[index].id);
                          },
                          icon: Icon(Icons.delete)),
                    ));
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: data.length);
              // return ListView.separated(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 20,
              //     vertical: 20,
              //   ),
              //   children: [
              //
              //
              //     ListView.builder(itemCount: 0,
              //         physics: NeverScrollableScrollPhysics(),
              //         shrinkWrap:true,
              //         itemBuilder: (context, index) {
              //
              //       return Card(child: ListTile(
              //      //   leading: Image.network('dddd'),
              //         title: Text(data[index].get('title')),
              //         subtitle: Text(data[index].get('price')),
              //         onTap:(){
              //           Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
              //         },
              //         trailing: IconButton(
              //             onPressed: () async{
              //               await delete(path: data[index].id);
              //             }, icon: Icon(Icons.delete)
              //
              //         ),),);
              //     })
              //   ],
              // );
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
    );

    /*
      Scaffold(
      body: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: const Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProduct.id);
              },
              child: const Text('Edit Product'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('View Orders'),
            ),
          ],
        ),


      ),
    );

    */
  }


 Product getProduct(QueryDocumentSnapshot snapshot){
Product product = Product();
product.path = snapshot.id;
product.title = snapshot.get('title');
product.description = snapshot.get('description');
product.category = snapshot.get('category');
product.price = snapshot.get('price');
product.location = snapshot.get('location');

return product;

  }

  Future<void> delete({required String path}) async {
    bool status = await FireStoreCotroller().delete(path: path);
    if (status) {
      showSnackBar(context: context, content: 'Product Deleted successfuly');
    }
  }
}
