import 'dart:async';
import 'dart:convert';

import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class ProfileRepo {
  const ProfileRepo();

  // method to change password
  // header : Content-Type application/json
  // old_password => # Required new_password => # Required
  // Code 400 bad request (missing fields, or missing token)
  // code 403 forbidden ( wrong old password)
  // code 500 internal error
  static Future<SuperResponseModel> changePassword(
      Map<String, dynamic> data) async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(ProfileAPIs.changePassword),
        header: await API.header(),
        body: json.encoder.convert(data)));
  }

  // method to get account data
  // header : Content-Type application/json
  // code 403 forbidden (Not Authorized)
  // code 500 internal error
  static Future<SuperResponseModel> profileDetails() async {
    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
        HttpHelper.url(ProfileAPIs.profileDetails),
        header: await API.header()));
  }

  //to edit account data such as (name ,phone , ...etc)
  // header : Content-Type application/json
  // name => # Required phone => # Required
  // Code 400 bad request (missing fields)
  // code 500 internal error
  static Future<SuperResponseModel> editProfileData(
      Map<String, dynamic> data) async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(ProfileAPIs.editProfile),
        header: await API.header(),
        body: json.encoder.convert(data)));
  }

  // method to upload account image
  // header : Content-Type application/json
  // avatar => # Required (base64)
  // Code 400 bad request (missing fields)
  // code 500 internal error
  static Future<SuperResponseModel> uploadAvatar(String avatarAsBase64) async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(ProfileAPIs.uploadAvatar),
        header: await API.header(),
        body: json.encoder.convert({'avatar': avatarAsBase64})));
  }
}
