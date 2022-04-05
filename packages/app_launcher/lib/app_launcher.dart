library app_launcher;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//----------------------------------------------------------------------------
// Please read README.md Carefully before using or modify ,thanks
//----------------------------------------------------------------------------

//use this package because if the main package has updated you don't update in all code , just update this package only

/// for launching a URL
/// It is a modified package and easy usage
/// add more method to be more easily
/// all method returned String =>
/// If a string is returned, the operation is failed.
/// If it is returned null, the operation is successful

abstract class AppLauncher {
  // to launch simple url on browser
  static Future<String> launchUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // pass phone number as argument and this method will launch to phone automatically
  static Future<String> launchToPhone(String phone) async {
    try {
      final url = 'tel://$phone';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch to Phone $url';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  //launch to whats app with saying hello
  static Future<String> launchToWhatsApp(
    String phone, {
    String msg = 'Hello',
  }) async {
    try {
      var url = '';

      if (Platform.isAndroid) {
        url = 'https://wa.me/$phone/?text=$msg';
      } else {
        url = 'https://api.whatsapp.com/send?phone=$phone=$msg';
      }

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch to whats app $url';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // launch to map => just pass lat and long and let it work
  static Future<String> launchToMap(
      {@required String lat, @required String lon}) async {
    assert(lat != null);
    assert(lon != null);

    try {
      final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // launch to map with direction => just pass first lat, first long , second lat and second long and let it work
  static Future<String> launchToMapWithDirection({
    @required String fLat,
    @required String fLong,
    @required String lLat,
    @required String lLong,
  }) async {
    assert(fLat != null && fLong != null && lLat != null && lLong != null);

    try {
      final origin = '$fLat,$fLong';
      final destination = '$lLat,$lLong';

      final url =
          'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=driving&dir_action=navigate';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
