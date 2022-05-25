
import 'package:firebase_storage/firebase_storage.dart';

class Product{
  late String path;
  late String id;
  late String title;
  late String image;
  late int imageInt;
  late String category;
  late String description;

  var price;

  Product();

  Product.fromMap(Map<String, dynamic> map){
    title =map['title'];
    image = map['image'];
    price = map['price'];
    category = map['category'];
    description = map['description'];

  }


  Map<String, dynamic> toMap(){
    Map<String, dynamic> map =  Map<String, dynamic>();
    map['title'] = title;
    map['image'] = image;
    map['price'] = price;
    map['category'] = category;
    map['description'] = description;
    return map;
  }



}