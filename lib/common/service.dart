import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppService {
  const AppService();

  static Future<void> setupSystemChrome() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.0),
        systemNavigationBarColor: Colors.white,
      ),
    );

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return;
  }

  static String convertFileToBase64(File file) {
    try {
      if (file == null || file?.path?.isEmpty != false) return '';

      return base64Encode(File(file.path).readAsBytesSync());
    } catch (e) {
      log('Exception in AppService.convertFileToBase64 : $e');
      return '';
    }
  }

  static String reformatHtmlCode(String value) {
    try {
      if (value == null || value.isEmpty) return '';

      return value.replaceAll('src="/web/', 'src="https://upsale.app/web/');
    } catch (e) {
      log('Exception in ProductService.reformatHtmlCode : $e');
      return value;
    }
  }

  static void turnOnEnhancedProtection({bool turnOn = true}) {
    // assert(turnOn != null);
    if (turnOn == true) {
      HttpOverrides.global = _MyHttpOverrides();
    }
  }
}


class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
