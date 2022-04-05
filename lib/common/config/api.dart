import 'dart:developer';
import 'package:get/get.dart';

import '../preferences/app_shared_preference.dart';

abstract class API {
  const API();

  static String domain = Get.locale.languageCode == 'en'
      ? 'http://34.202.173.125:8069'
      : 'http://34.202.173.125:8069/${Get.locale.languageCode}';
  static String baseUrl = '$domain/api/v1';
  // static String baseUrl = '$domain/api/v1/';

  // static const String _imagesServer = '$_domain/public/images';

  static Future<Map<String, String>> header({
    Map<String, String> moreHeaderKeys,
  }) async {
    final temp = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final token = await getUserTokenFromSharedPreference();

      if (token != null) {
        temp['Authorization'] =
            'Bearer ${await getUserTokenFromSharedPreference()}';
      }

      if (moreHeaderKeys != null) temp.addAll(moreHeaderKeys);

      return temp;
    } catch (e) {
      log('Exception in API.header : $e');
    }
    return temp;
  }

  static Future<String> getUserTokenFromSharedPreference() async {
    try {
      final data = await AppSharedPreference.userData.getUserData();

      if (data == null || data.isEmpty) return null;
      return data['token'] as String;
    } catch (e) {
      log('Exception in API.getUserTokenFromSharedPreference : $e');
      return null;
    }
  }

  static String imageUrl(String image) {
    if (image == null) {
      return '$domain/web/image/product.template/513516565/image_512?unique=418db60';
    }
    return '$domain$image';
  }
}
