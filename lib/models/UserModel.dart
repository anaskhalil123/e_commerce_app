class Userm {
  late String id;
  late String name;
  late String email;
  late bool isTeacher;

  Userm(this.id, this.name, this.email, this.isTeacher);

  //{required this.id ,required this.name, required this.email, required this.isTeacher}

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['isTeacher'] = isTeacher;

    return map;
  }

  Userm.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    isTeacher = map['isTeacher'];
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
