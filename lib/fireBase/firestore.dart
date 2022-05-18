import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Product.dart';

import '../models/User.dart';

class FireStoreCotroller{

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<bool> storeUser({required User user}) async{
    return await _firebaseFirestore.collection('Users').doc('${user.id}').set(user.toMap()).then((value) {
      //DocumentReference reference = value1;
      return true;
    }
    ).catchError((error) => false);

  }

  Future<QueryDocumentSnapshot> getMyInformation({required String id}) async{
    var snapshot = (await _firebaseFirestore.collection('Users').doc(id).snapshots()) as QueryDocumentSnapshot;


    QueryDocumentSnapshot query =snapshot.data.hashCode as QueryDocumentSnapshot<Object?>;
    return query;

    // User user = User(snapshot.id, snapshot.get('title'), snapshot.get('email'), snapshot.get('isTeacher'));
    //User.path = ;
   // User.title = ;
    // product.description = snapshot.get('description');
    // product.category = snapshot.get('category');
    // product.price = snapshot.get('price');
    // product.location = snapshot.get('location');

    // return     User user = User(snapshot.id, snapshot.get('title'), snapshot.get('email'), snapshot.get('isTeacher'));
    ;
    // return User.fromMap(userMap);
    //return  (await _firebaseFirestore.collection('Users').doc(id).snapshots()) as Map<String, dynamic> ;
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

   Future<bool> update({required String path, required Product product}) async{

   return await _firebaseFirestore.collection('Products')
        .doc(path)
        .update(product.toMap())
        .then((value) => true)
        .catchError((eroor) => false);

   }

   Future<bool> delete({required String path}) async{
     return await _firebaseFirestore.collection('Products').doc(path).delete().then((value) => true).catchError((eroor) => false);
     
   }
}