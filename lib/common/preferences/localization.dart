import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

///this class used to save last language selected code and do CRUD operation
/// save last language code to help user when open application
class LocalizationSharedPreference {
  const LocalizationSharedPreference();

  //unique shared preference key
  static const String _key = 'localizations';

  //get last language code from shared preferences
  //if has no data or an exception has occurs return null
  Future<String> getLocalization() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_key);
    } catch (e) {
      log('Exception in LocalizationSharedPreference.getLocalization :$e');
      return null;
    }
  }

  //save last language code data
  //if data stored successfully return true
  Future<bool> setLocalization(String data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, data);
      return true;
    } catch (e) {
      log('Exception in LocalizationSharedPreference.setLocalization :$e');
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
      log('Exception in LocalizationSharedPreference.clearData :$e');
      return false;
    }
  }
}
