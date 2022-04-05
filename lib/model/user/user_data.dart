import 'dart:convert';
import 'dart:developer';

import '../usage_criteria.dart';

/// Contain all user data
class UserData implements UsageCriteria {
  /// Initializes [id, name, email, phone, avatar] of object.
  const UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.firebaseToken,
  });

  ///user id
  final int id;

  /// user name [full name]
  final String name;

  /// email of user
  final String email;

  /// user phone
  final String phone;

  /// user image
  final String avatar;

  /// firebase Token
  final String firebaseToken;

  ///copy data from this object and return new object instance
  UserData copyWith({
    int id,
    String name,
    String email,
    String phone,
    String avatar,
    String firebaseToken,
  }) {
    try {
      return UserData(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatar: avatar ?? this.avatar,
        firebaseToken: firebaseToken ?? this.firebaseToken,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in UserData.copyWith : $e');
      return const UserData();
    }
  }

  /// Named constructor to create object instance from string json data
  factory UserData.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const UserData();

      return UserData.fromMap(json.decode(str) as Map<String, dynamic>);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in UserData.fromJson : $e');
      return const UserData();
    }
  }

  /// convert object to string json data
  String toJson() => json.encode(toMap());

  /// Named constructor to create object instance from map of data
  factory UserData.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const UserData();
      return UserData(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        avatar: json['avatar'] as String,
        firebaseToken: json['firebase_token'] as String,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in UserData.fromMap : $e');
      return const UserData();
    }
  }

  /// convert object to map of data
  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'firebase_token': firebaseToken,
      };
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in UserData.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in UserData.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null && email != null;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in UserData.usable : $e');
      return false;
    }
  }
}
