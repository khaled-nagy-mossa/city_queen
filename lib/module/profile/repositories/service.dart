import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../model/user/user_data.dart';
import 'repo.dart';

abstract class ProfileService {
  const ProfileService();


  static Future<String> changePassword(
      {@required Map<String, dynamic> data}) async {
    try {
      final res = await ProfileRepo.changePassword(data);

      if (res.hasError == true) throw res?.msg ?? 'Unknown Error';

      if (res.json['result']['error'] != null) {
        throw res.json['result']['error']['msg'] as String;
      }

      return null;
    } catch (e) {
      log('Exception in changePassword in ProfileService : $e');
      return e.toString();
    }
  }

  static Future profileDetails() async {
    try {
      final res = await ProfileRepo.profileDetails();

      if (res.hasError == true) throw res.msg;

      return UserData.fromMap(
        res.json['result']['data']['usermodel'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in AuthService.profileDetails : $e');
      return e.toString();
    }
  }

  static Future editProfileData(Map<String, dynamic> data) async {
    try {
      final res = await ProfileRepo.editProfileData(data);

      if (res.hasError == true) throw Exception(res.msg);

      return UserData.fromMap(
        res.json['result']['data']['usermodel'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in uploadAvatar in ProfileService : $e');
      return e.toString();
    }
  }

  static Future uploadAvatar({@required String avatarAsBase64}) async {
    try {
      final res = await ProfileRepo.uploadAvatar(avatarAsBase64);

      if (res.hasError == true) throw Exception(res.msg);

      return UserData.fromMap(
        res.json['result']['data']['usermodel'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in uploadAvatar in ProfileService : $e');
      return e.toString();
    }
  }
}
