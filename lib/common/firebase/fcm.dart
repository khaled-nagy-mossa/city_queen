import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification.dart';

abstract class FCM {
  const FCM();

  ///put this in main method
  static void setupBackgroundMessages() {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    await LocalNotificationService.display(message);
  }

  static Future<void> setupListener() async {
    await _getInitialMessage();
    _onMessage();
    _onMessagesOpenedApp();

    FirebaseMessaging.onMessage.listen((message) {
      if (message?.notification != null) {}
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
    FirebaseMessaging.onBackgroundMessage((message) {
      return;
    });
  }

  ///gives you the message on which user taps
  ///and it opened the app from terminated state
  static Future<void> _getInitialMessage() async {
    await FirebaseMessaging.instance.getInitialMessage();
  }

  ///forground work
  static void _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
      } else {}
      LocalNotificationService.display(message);
    });
  }

  ///When the app is in background but opened and user tabs
  static void _onMessagesOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }
}
