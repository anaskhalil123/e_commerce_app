


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "SearchScreen";
  //const SearchScreen({Key? key}) : super(key: key);
   late TextEditingController? controller;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _titleTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextFormField(
       // controller: controller,


        decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.black26)
    )
    )
    );
  }
}
