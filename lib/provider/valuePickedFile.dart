

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ValuePickedFile extends ChangeNotifier{
  String _pickedFile = "";


  changePickedFile(String value){
    _pickedFile = value;
    notifyListeners();
  }
}