import 'notification_cubit.dart';

extension NotificationCubitExtension on NotificationViewCubit{
  bool get hasData {
    return notificationList != null && notificationList.usable;
  }
}