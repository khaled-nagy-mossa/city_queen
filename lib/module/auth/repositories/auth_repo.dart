import 'dart:async';
import 'dart:convert';

import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class AuthRepo {
  const AuthRepo();

  // method to sign in
  // header : Content-Type application/json
  // email => # Required password => # Required role => # required, accept (client - manager - driver)
  // Code 400 bad request (missing fields)
  // code 403 forbidden ( wrong email or password - login for different role)
  // code 500 internal error
  static Future<SuperResponseModel> signIn(Map<String, dynamic> data) async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(AuthAPIs.signIn),
        header: await API.header(),
        body: json.encoder.convert(data)));
  }

  // method to sign up
  // header : Content-Type application/json
  // phone => # Required email => # Required phone => # Required password => # Required
  // Code 400 bad request (missing fields)
  // code 500 internal error
  static Future<SuperResponseModel> signUp(Map<String, dynamic> data) async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(AuthAPIs.signUp),
        header: await API.header(),
        body: json.encoder.convert(data)));
  }

  // method if user forget password it will send email to user
  // header : Content-Type application/json
  // email => # Required
  // Code 400 bad request (missing fields)
  // code 500 internal error
  static Future<SuperResponseModel> forgetPassword(
      Map<String, dynamic> data) async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(AuthAPIs.forgetPassword),
        header: await API.header(),
        body: json.encoder.convert(data)));
  }
}
