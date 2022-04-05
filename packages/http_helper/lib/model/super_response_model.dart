import 'dart:developer';

import 'package:http/http.dart' as http;

///SuperResponseModel it contain 4 members
///it is like http.Response but it contain more members to help you and request be more than easily
/// it help you to contain
/// 1- res => save a http.Response has returned
/// 2- hasError => it return false if Not Exception Occurs and  (statusCode >= 100 && statusCode <= 299)
/// 3- msg => it save exception message or status code message
/// 4- json => it save the returned value from request [ json.decode(htt.Response.body) ]

///this class used in all request and it returned as a returned object
class SuperResponseModel {
  http.Response res;
  bool hasError;
  String msg;
  Map<String, dynamic> json;

  SuperResponseModel({this.res, this.hasError, this.msg, this.json});

  void printData() {
    try {
      log('Has Error : $hasError');
      log('Message : $msg');
      log('Json : $json');
      if (res != null) log('Status : ${res.statusCode}');
      if (res != null) log('Body : ${res.body}');
    } catch (e) {
      log('Exception in SuperResponseModel.printData : $e');
    }
  }
}
