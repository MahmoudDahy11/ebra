import 'package:ebra/core/constant/app_const.dart';
import 'package:hive_flutter/hive_flutter.dart';


/*
 * LocalStorageService class
 * manages local storage of user data using Hive
 * provides methods to save, retrieve, and clear user data
 * checks if a user is logged in
 * initializes Hive and opens the necessary box
 */
class LocalStorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Future<void> saveUserData({
    required String uid,
    required String email,
    String? name,
    String? photoUrl,
  }) async {
    var box = Hive.box(boxName);
    await box.put('uid', uid);
    await box.put('email', email);
    await box.put('name', name ?? '');
    await box.put('photoUrl', photoUrl ?? '');
    await box.put('isLoggedIn', true);
  }

  static bool isLoggedIn() {
    var box = Hive.box(boxName);
    return box.get('isLoggedIn', defaultValue: false);
  }

  static Map<String, dynamic> getUserData() {
    var box = Hive.box(boxName);
    return {
      'uid': box.get('uid', defaultValue: ''),
      'email': box.get('email', defaultValue: ''),
      'name': box.get('name', defaultValue: ''),
      'photoUrl': box.get('photoUrl', defaultValue: ''),
    };
  }

  static Future<void> clearUserData() async {
    var box = Hive.box(boxName);
    await box.clear();
  }
}
