import '../../../common/config/api.dart';

abstract class NotificationAPIs {
  const NotificationAPIs();

  //to get all notifications
  //type post
  //params => no params
  static final getNotifications = '${API.baseUrl}/get_notifications',
      //to remove notification from notifications list
      //type post
      //params => no params
      removeNotification = '${API.baseUrl}/remove_notification',

      ///to update user fcm token
      setFirebaseToken = '${API.baseUrl}/set_firebase_token';
}
