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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 18),),


      ),


      body:Padding(
      padding: const EdgeInsets.all(20),

        child: Column(
        children: [

        Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Column(
          children: [
            ElevatedButton(

              onPressed: (){
                Navigator.pushNamed(context, AddProduct.id);
              }, child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(

                  minimumSize: Size(80, 80)),

            ),
            SizedBox(height: 10,),
            Text('Add product' , style: TextStyle(fontSize: 12),)
          ],
        ),

          Column(
            children: [
              ElevatedButton(
                onPressed: (){}, child: Icon(Icons.view_comfortable),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(80, 80)
                ),
                //_upload('camera')
                // icon: const Icon(Icons.add),
                // label: const Text('Add product')


              ),
              SizedBox(height: 10,),
              Text('View orders' , style: TextStyle(fontSize: 12),)
            ]
          )
    ]),

        Expanded(
          child:
        StreamBuilder<QuerySnapshot>(
            stream: FireStoreCotroller().read(),
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




                                     child:
                                    DecoratedBox(

                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: (7), horizontal: 7),

                                  //  data[index].get('image') != "" ?
                                        child: data[index].get('image') != "" ? Image.network(
                                        data[index].get('image'),

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
                                        ):
                                      //  const Image(image: AssetImage('images/placeholder.png',), fit:BoxFit.cover)
                                        Image.network('https://firebasestorage.googleapis.com/v0/b/buy-it-73d4f.appspot.com/o/placeholder.png?alt=media&token=e0863ab9-be10-4ed8-8697-c5a9ca6b1746',
                                          fit:BoxFit.cover ,),

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
                                 child:  Text(data[index].get('title'),
                                   style: TextStyle(fontSize: 18,
                                     fontWeight: FontWeight.bold

                                   ),

                                 ),
                                 alignment: AlignmentDirectional.topStart,
                               ),
                                Container(
                                  child: Text(data[index].get('price'),
                                    textAlign: TextAlign.center,
                                  ) ,

                                  margin: EdgeInsets.only(top: 10),
                                  alignment: AlignmentDirectional.topStart,
                                )

                              ],
                            ),
                            width: width * 0.4-23,
                          ),
                          Container(
                            child: Row(
                              children: [

                                IconButton(
                                    onPressed: () async {
                                      Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EditProduct(getProduct(data[index]))));
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blue,),

                               // alignment: AlignmentDirectional.bottomEnd,
                                ),

                                IconButton(
                                      onPressed: () async {
                                        await delete(path: data[index].id);
                                      },

                                      icon: Icon(Icons.delete, color: Colors.red,),

                                )

                              ],

verticalDirection: VerticalDirection.up,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.center,

                            ),

                            margin: EdgeInsets.only(top: 80,right: 5,),

                            alignment: AlignmentDirectional.bottomEnd,
                          )

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

        )
    ],
    ),
      ));


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

  Future<void> delete({required String path}) async {
    bool status = await FireStoreCotroller().delete(path: path);
    if (status) {
      showSnackBar(context: context, content: 'Product Deleted successfuly');
    }
  }


}
