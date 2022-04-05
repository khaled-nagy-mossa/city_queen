import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class NotificationConfig {
  const NotificationConfig();

  //get all notifications
  static Future<SuperResponseModel> getNotifications() async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(NotificationAPIs.getNotifications),
        header: await API.header(),
        body: json.encoder.convert(<String ,dynamic>{})));
  }

  static Future<SuperResponseModel> removeNotification({
    @required int notificationId,
  }) async {
    assert(notificationId != null);

    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(NotificationAPIs.removeNotification),
        header: await API.header(),
        body: json.encoder.convert({'notification_id': notificationId})));
  }


  static Future<SuperResponseModel> setFirebaseToken({
    @required String fcmToken,
  }) async {
    assert(fcmToken != null);

    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(NotificationAPIs.setFirebaseToken),
        header: await API.header(),
        body: json.encoder.convert({'firebase_token': fcmToken})));
  }
}
