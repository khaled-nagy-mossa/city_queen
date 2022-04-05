import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/contact_us.dart';
import 'repo.dart';

abstract class DocumentService {
  const DocumentService();

  static Future contactUs() async {
    try {
      final res = await DocumentRepo.contactUs();

      if (res.hasError) throw res.msg;

      return ContactUs.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in staticPages in contactUs: $e');
      return e.toString();
    }
  }

  static Future<String> staticPages({@required String endPoint}) async {
    assert(endPoint != null);

    try {
      final res = await DocumentRepo.pages(endPoint: endPoint);

      if (res.hasError) throw res.msg;

      return res.json['result']['content'] as String;
    } catch (e) {
      log('Exception in staticPages in PagesService: $e');
      return '';
    }
  }
}
