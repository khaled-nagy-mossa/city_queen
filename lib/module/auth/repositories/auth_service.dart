import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../model/user/user.dart';
import '../model/server/forget_password.dart';
import 'auth_repo.dart';

abstract class AuthService {
  const AuthService();

  static Future signIn({@required Map<String, dynamic> data}) async {
    try {
      final res = await AuthRepo.signIn(data);

      if (res.hasError == true) throw res.msg;

      return User.fromMap(
        res.json['result']['data'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in AuthService.signIn : $e');
      return e.toString();
    }
  }

  static Future signUp({@required Map<String, dynamic> data}) async {
    try {
      final res = await AuthRepo.signUp(data);

      if (res.hasError == true) return res.msg;

      return User.fromMap(
        res.json['result']['data'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in AuthService.signUp : $e');
      return e.toString();
    }
  }

  static Future forgetPassword({@required String email}) async {
    try {
      final res =
          await AuthRepo.forgetPassword(<String, dynamic>{'email': email});

      if (res.hasError == true) throw res.msg;

      return ForgetPassword.fromMap(
          res.json['result']['data'][0] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in forgetPassword in ProfileService : $e');
    }
  }
}
