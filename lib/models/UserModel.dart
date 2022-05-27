class Userm {
  late String id;
  late String name;
  late String email;
  late String? imagePath;
  late String? writeAboutYourSelf;
  late bool isAdmin;

  Userm(this.id, this.name, this.email, this.isAdmin,
      [this.writeAboutYourSelf, this.imagePath]);

  //{required this.id ,required this.name, required this.email, required this.isTeacher}

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['isAdmin'] = isAdmin;
    if (writeAboutYourSelf != null) {
      map['writeAboutYourSelf'] = writeAboutYourSelf;
    } else {
      map['writeAboutYourSelf'] = '';
    }

    if (imagePath != null) {
      map['imagePath'] = imagePath;
    } else {
      map['imagePath'] = '';
    }

    return map;
  }

  Userm.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    isAdmin = map['isAdmin'];
    if (map['writeAboutYourSelf'] != null) {
      writeAboutYourSelf = map['writeAboutYourSelf'];
    } else {
      writeAboutYourSelf = '';
    }

    if (map['imagePath'] != null) {
      imagePath = map['imagePath'];
    } else {
      imagePath = '';
    }
  }

// User.fromMap(Map<String, dynamic> map){
//    title =map['title'];
//    image = map['image'];
//    price = map['price'];
//    category = map['category'];
//    description = map['description'];
//    location = map['location'];
//
// }
}
