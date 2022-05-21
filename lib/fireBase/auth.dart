import 'package:firebase_auth/firebase_auth.dart';
class Auth{

  final _auth = FirebaseAuth.instance;


   Future<UserCredential> signUp(String email, password) async{
   final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

   return authResult;
  }

  Future<UserCredential> signIn(String email, password) async{
    final authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return authResult;
  }

  Future<void> signOut() async{
     await _auth.signOut();
  }

}
