import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Product.dart';

class Purchase {
  late String id;
  late String title;
  late String description;
  var price;
  late String category;
  late String image;
  late int quantity;

   bool isOrdered =false;



  Purchase({required this.id,required this.title,

    required this.description, required this.price,
    required this.category, required this.image,
    required this.quantity});

  Purchase.fromMap(Map<String, dynamic> map){
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
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['price'] = price;
    map['category'] = category;
    map['description'] = description;
    map['quantity'] = quantity;
    map['isOrdered'] = isOrdered;
    map['dateAdded'] = Timestamp.now();
    return map;
  }


}
