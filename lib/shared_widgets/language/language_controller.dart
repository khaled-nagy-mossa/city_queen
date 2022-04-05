import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  void changeLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (Get.locale.languageCode == "ar") {
      Get.updateLocale(Locale('en'));
      // await box.write("LANG", 'en');
      sharedPreferences.setString("LANG", 'en');
    } else {
      Get.updateLocale(Locale('ar'));
      // await box.write("LANG", 'en');
      sharedPreferences.setString("LANG", 'ar');
    }
  }
}
