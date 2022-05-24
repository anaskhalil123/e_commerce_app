
class Product{
  late String path;
  late String id;
  late String title;
  late String image;
  late int imageInt;
  late String category;
  late String description;
  // TODO Location will ber removed
  late String location;
  var price;

  Product();

  Product.fromMap(Map<String, dynamic> map){
    title =map['title'];
    image = map['image'];
    price = map['price'];
    category = map['category'];
    description = map['description'];
    location = map['location'];

  }


  Map<String, dynamic> toMap(){
    Map<String, dynamic> map =  Map<String, dynamic>();
    map['title'] = title;
    map['image'] = image;
    map['price'] = price;
    map['category'] = category;
    map['description'] = description;
    map['location'] = location;
    return map;
  }



}