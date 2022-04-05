import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

///this class used to save all user data and do CRUD operation
class UserDataSharedPreference {
  const UserDataSharedPreference();

  //unique shared preference key
  static const String _key = 'user_data';

  //get user data from shared preferences
  //if has no data or an exception has occurs return null
  Future<Map<String, dynamic>> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final temp = prefs.getString(_key);

      if (temp == null) return <String ,dynamic>{};

      final data = json.decode(temp) as Map<String, dynamic>;
      return data;
    } catch (e) {
      log('Exception in UserDataSharedPreference.getUserData : $e');
      return <String ,dynamic>{};
    }
  }

  //save user data
  //if data stored successfully return true
  //data argument passing as map and it encoding to string to save in shared preferences
  Future<bool> setUserData(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, json.encode(data));
      return true;
    } catch (e) {
      log('Exception in UserDataSharedPreference.setUserData : $e');
      return false;
    }
  }

  //clear all data that contain this key
  Future<bool> clearData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      return true;
    } catch (e) {
      log('Exception in UserDataSharedPreference.clearData : $e');
      return false;
    }
  }
}
