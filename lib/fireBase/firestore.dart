import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/OrderProduct.dart';

import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/purchase.dart';


class FireStoreCotroller{

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<bool> storeUser({required Userm user}) async{
    return await _firebaseFirestore.collection('Users').doc('${user.id}').set(user.toMap()).then((value) {
      //DocumentReference reference = value1;
      return true;
    }
    ).catchError((error) => false);

  }


  Future<DocumentSnapshot<Map<String, dynamic>>> getMyInformation({required String id}) async{
    var snapshot = (await _firebaseFirestore.collection('Users').doc(id).get());


   // QueryDocumentSnapshot query =snapshot.data.hashCode as QueryDocumentSnapshot<Object?>;
    return snapshot;
  }

   Future<bool> create({required Product product}) async{
     return await _firebaseFirestore.collection('Products').add(product.toMap()).then((value) {
       DocumentReference reference = value;
       return true;
     }

     ).catchError((error) => false);

   }

   Stream<QuerySnapshot> read() async*{
     yield* _firebaseFirestore.collection('Products').snapshots();
   }

  Stream<QuerySnapshot> readProductsInMyCart() async*{
    final _auth = FirebaseAuth.instance;
    yield* _firebaseFirestore.collection('Users').doc(_auth.currentUser!.uid).collection('MyCart').snapshots();
  }

  Stream<QuerySnapshot> readOrdersdProducts() async*{
    yield* _firebaseFirestore.collection('OrderProduct').snapshots();
  }


  Future<bool> update({required String path, required Product product}) async{

   return await _firebaseFirestore.collection('Products')
        .doc(path)
        .update(product.toMap())
        .then((value) => true)
        .catchError((eroor) => false);

   }


   Future<bool> addToCart({required Purchase purchase}) async{
     final _auth = FirebaseAuth.instance;
    // var hashmap =HashMap<String, dynamic>();
    //  hashmap['id'] = path;
    // hashmap['quantity'] = quantity;
     //String myId = AppPrefernces().myId.toString();

     return await _firebaseFirestore.collection('Users').doc(_auth.currentUser!.uid).collection('MyCart')
         .add(purchase.toMap()).then((value) {
       //DocumentReference reference = value1;
       //.doc('zDuIrO3wdce6bDfTCWyK7XfvJ043').collection('MyCart').doc('${path}').set(hashmap)
       return true;
     }
     ).catchError((error) => false);

         }


  Future<bool> addToOrders({required OrderProduct orderProduct, required String path}) async{
    // final _auth = FirebaseAuth.instance;
    // var hashmap =HashMap<String, dynamic>();
    //  hashmap['id'] = path;
    // hashmap['quantity'] = quantity;

    return await _firebaseFirestore.collection('OrderProduct').doc(path).set(orderProduct.toMap()).then((value) {
      //DocumentReference reference = value1;
      //.doc('zDuIrO3wdce6bDfTCWyK7XfvJ043').collection('MyCart').doc('${path}').set(hashmap)
      return true;
    }
    ).catchError((error) => false);

  }


  Future<bool> isOrdered({required String id,required Purchase purchase}) async{
    final _auth = FirebaseAuth.instance;
    // var hashmap =HashMap<String, dynamic>();
    //  hashmap['id'] = path;
    // hashmap['quantity'] = quantity;

    return await _firebaseFirestore.collection('Users').doc(_auth.currentUser!.uid).collection('MyCart').doc(id).set(purchase.toMap()).then((value) {
      //DocumentReference reference = value1;
      //.doc('zDuIrO3wdce6bDfTCWyK7XfvJ043').collection('MyCart').doc('${path}').set(hashmap)
      return true;
    }
    ).catchError((error) => false);

  }




   Future<bool> delete({required String path}) async{
     return await _firebaseFirestore.collection('Products').doc(path).delete().then((value) => true).catchError((eroor) => false);

   }

  Future<bool> acceptOrderDeleteFromOrder({required String path}) async{
    return await _firebaseFirestore.collection('OrderProduct').doc(path).delete().then((value) => true).catchError((eroor) => false);

  }

  Future<bool> acceptOrderDeleteFromMyCart({required String path}) async{
    final _auth = FirebaseAuth.instance;
    return await _firebaseFirestore.collection('Users').doc(_auth.currentUser!.uid).collection('MyCart').doc(path).delete().then((value) => true).catchError((eroor) => false);

  }



}