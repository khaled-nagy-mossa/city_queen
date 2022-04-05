import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class DocumentRepo {
  const DocumentRepo();

  //to get application contact_us
  // header : Content-Type application/json
  static Future<SuperResponseModel> contactUs() async {
    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(DocumentAPIs.contactUs),
      header: await API.header(),
    ));
  }

  // get all Static pages
  // header : Content-Type application/json
  static Future<SuperResponseModel> pages({@required String endPoint}) async {
    assert(endPoint != null);

    final api = '${DocumentAPIs.pages}?page=$endPoint';
    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(api),
      header: await API.header(),
    ));
  }
}
