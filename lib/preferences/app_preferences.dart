import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class AppPrefernces{

  static final AppPrefernces _instance = AppPrefernces._internal();
late SharedPreferences _sharedPreferences;
  factory AppPrefernces(){
    return _instance;
  }
   AppPrefernces._internal();

  Future<void> initPreferences() async {
     _sharedPreferences = await SharedPreferences.getInstance();
}

Future<void> save({required User user}) async{
    await _sharedPreferences.setBool('logged_in', true);
await _sharedPreferences.setString('email', user.email);
await _sharedPreferences.setString('name', user.name);
    await _sharedPreferences.setBool('isTeacher', user.isTeacher);
  }

  bool get loggedIn => _sharedPreferences.getBool('logged_in')?? false;
  bool get isTheacher => _sharedPreferences.getBool('isTeacher')?? false;

  Future<bool> logout() async{
    return _sharedPreferences.clear();

  }

}