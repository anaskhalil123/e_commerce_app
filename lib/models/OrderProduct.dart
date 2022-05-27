


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/purchase.dart';

class OrderProduct {
  //late Purchase purchase;
  late String id;
  late String title;
  late String description;
  var price;
  late String category;
  late String image;
  late int quantity;

  late String idOwnerOrder;
  late String nameOwnerOrder;
  late String imageOwnerOrder;


  OrderProduct({required this.id,required this.title,

    required this.description, required this.price,
    required this.category, required this.image,
    required this.quantity,
    required this.idOwnerOrder, required this.nameOwnerOrder, required this.imageOwnerOrder});


  OrderProduct.fromMap(Map<String, dynamic> map){
    id = map['id'];
    title =map['title'];
    image = map['image'];
    price = map['price'];
    category = map['category'];
    description = map['description'];
    quantity = map['quantity'];

  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map =  Map<String, dynamic>();
    //map['ipurchased'] = purchase;
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['price'] = price;
    map['category'] = category;
    map['description'] = description;
    map['quantity'] = quantity;
    map['idOwnerOrder'] = idOwnerOrder;
    map['nameOwnerOrder'] = nameOwnerOrder;
    map['imageOwnerOrder'] = imageOwnerOrder;
    map['dateAdded'] = Timestamp.now();
    return map;
  }

}

