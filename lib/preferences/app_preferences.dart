import 'package:shared_preferences/shared_preferences.dart';

import '../fireBase/firestore.dart';
import '../models/UserModel.dart';

class AppPrefernces {
  static final AppPrefernces _instance = AppPrefernces._internal();
  late SharedPreferences _sharedPreferences;

  factory AppPrefernces() {
    return _instance;
  }

  AppPrefernces._internal();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Userm user}) async {
    print('user id' + user.id);
    // print('user writeAboutMySelf' + user.writeAboutYourSelf!);
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setString('email', user.email);
    await _sharedPreferences.setString('id', user.id);
    await _sharedPreferences.setString('name', user.name);
    await _sharedPreferences.setString('image', user.imagePath ?? '');
    await _sharedPreferences.setString(
        'writeAboutYourSelf', user.writeAboutYourSelf ?? '');
    await _sharedPreferences.setBool('isAdmin', user.isAdmin);
  }

  Future<void> updateUserName({required String name}) async {
    await _sharedPreferences.setString('name', name);

    await FireStoreCotroller().updateUser(
        user: Userm(myId, myName, myEmail, isAdmin, writeAboutMySelf, myImage));
  }

  Future<void> updateUserEmail({required String email}) async {
    await _sharedPreferences.setString('email', email);

    await FireStoreCotroller().updateUser(
        user: Userm(myId, myName, myEmail, isAdmin, writeAboutMySelf, myImage));
  }

  // added, update writeAboutYourSelf field in shredPref
  Future<void> updateWriteAboutYourSelf(
      {required String writeAboutYourSelf}) async {
    await _sharedPreferences.setString(
        'writeAboutYourSelf', writeAboutYourSelf);

    print('user writeAboutMySelf is $writeAboutMySelf');
    bool status = await FireStoreCotroller().updateUser(
        user: Userm(myId, myName, myEmail, isAdmin, writeAboutMySelf, myImage));

    print('status is $status');
  }

  // added image field in shredPref
  Future<void> updateUserImage({required String image}) async {
    await _sharedPreferences.setString('image', image);

    await FireStoreCotroller().updateUser(
        user: Userm(myId, myName, myEmail, isAdmin, writeAboutMySelf, myImage));
  }

  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  bool get isAdmin => _sharedPreferences.getBool('isAdmin') ?? false;

  String get myId => _sharedPreferences.getString('id') ?? '';

  String get writeAboutMySelf =>
      _sharedPreferences.getString('writeAboutYourSelf') ?? '';

  String get myName => _sharedPreferences.getString('name') ?? '';

  String get myEmail => _sharedPreferences.getString('email') ?? '';

  String get myImage => _sharedPreferences.getString('image') ?? '';

  Future<bool> logout() async {
    return _sharedPreferences.clear();
  }
}
