import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

import 'notification.dart';

class NotificationList implements UsageCriteria {
  const NotificationList({
    this.notifications,
  });

  final List<UserNotification> notifications;

  NotificationList copyWith({
    List<UserNotification> notifications,
  }) {
    try {
      return NotificationList(
        notifications: notifications ?? this.notifications,
      );
    } catch (e) {
      log('Exception in NotificationList.copyWith : $e');
      return this;
    }
  }

  factory NotificationList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const NotificationList();

      return NotificationList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in NotificationList.fromJson : $e');
      return const NotificationList();
    }
  }

  String toJson() => json.encode(toMap());

  factory NotificationList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const NotificationList();

      return NotificationList(
        notifications: List<UserNotification>.from(
          ((json['notifications'] ?? <Map>[]) as List).map<UserNotification>(
            (dynamic x) => UserNotification.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in NotificationList.fromMap : $e');
      return const NotificationList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'notifications': List<UserNotification>.from(
          notifications?.map<Map>((dynamic x) => x?.toMap() as Map) ?? <Map>[],
        ),
      };
    } catch (e) {
      log('Exception in NotificationList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return notifications != null;
    } catch (e) {
      log('Exception in NotificationList.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in NotificationList.unUsable : $e');
      return true;
    }
  }
}
