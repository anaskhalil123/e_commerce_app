


import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageController{
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

Future getImaged() async{

}
  Future<void> uploadImage({required File file,
    required void Function(bool status,TaskState state, String message, {Reference? reference}) eventHandler})async{

    try{
     UploadTask uploadTask = _firebaseStorage.ref('images/${DateTime.now().toString().replaceAll(' ', '_')}').putFile(file);
   uploadTask.snapshotEvents.listen((event) {
     if(event.state == TaskState.running){
       eventHandler(false,event.state, '');

     }else if(event.state == TaskState.success){
       eventHandler(true, event.state, 'Uploaded successfully', reference: event.ref);
     }else if(event.state == TaskState.error){
       eventHandler(false, event.state, 'UPLOADED FAILED');
     }


   });
    }catch (e){
      print(e);
    }
    
  }

}