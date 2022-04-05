import 'dart:convert';

import 'dart:developer';

import '../../../model/usage_criteria.dart';

class UserNotification implements UsageCriteria {
  const UserNotification({
    this.id,
    this.title,
    this.text,
    this.image,
    this.sentDate,
  });

  final int id;
  final String title;
  final String text;
  final String image;
  final DateTime sentDate;

  UserNotification copyWith({
    int id,
    String title,
    String text,
    String image,
    DateTime sentDate,
  }) {
    try {
      return UserNotification(
        id: id ?? this.id,
        title: title ?? this.title,
        text: text ?? this.text,
        image: image ?? this.image,
        sentDate: sentDate ?? this.sentDate,
      );
    } catch (e) {
      log('Exception in UserNotification.copyWith : $e');
      return this;
    }
  }

  factory UserNotification.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const UserNotification();

      return UserNotification.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in UserNotification.fromJson : $e');
      return const UserNotification();
    }
  }

  String toJson() => json.encode(toMap());

  factory UserNotification.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const UserNotification();

      return UserNotification(
        id: json['id'] as int,
        title: json['title'] as String,
        text: json['text'] as String,
        image: json['image'] as String,
        sentDate: DateTime.parse((json['sent_date'] ?? '') as String),
      );
    } catch (e) {
      log('Exception in UserNotification.fromMap : $e');
      return const UserNotification();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'title': title,
        'text': text,
        'image': image,
        'sent_date': sentDate?.toIso8601String(),
      };
    } catch (e) {
      log('Exception in UserNotification.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return id != null && (title != null || text != null || image != null);
    } catch (e) {
      log('Exception in UserNotification.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in UserNotification.unUsable : $e');
      return true;
    }
  }
}
