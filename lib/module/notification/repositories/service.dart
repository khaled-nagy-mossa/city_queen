import 'package:flutter/material.dart';

import '../../../model/user/user_data.dart';
import '../model/notification_list.dart';
import 'repo.dart';

abstract class NotificationService {
  const NotificationService();

  static Future getNotifications() async {
    try {
      final res = await NotificationConfig.getNotifications();

      if (res.hasError) throw res.msg;

      return NotificationList.fromMap(
        res.json['result'] as Map<String, dynamic>,
      );
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> removeNotification({
    @required int notificationId,
  }) async {
    assert(notificationId != null);

    try {
      final res = await NotificationConfig.removeNotification(
        notificationId: notificationId,
      );

      if (res.hasError) throw res.msg;

      return '';
    } catch (e) {
      return e.toString();
    }
  }

  static Future setFirebaseToken({@required String fcmToken}) async {
    try {
      final res = await NotificationConfig.setFirebaseToken(fcmToken: fcmToken);

      if (res.hasError) throw res.msg;

      return UserData.fromMap(
        res.json['result']['data']['usermodel'] as Map<String, dynamic>,
      );
    } catch (e) {
      return e.toString();
    }
  }
}
