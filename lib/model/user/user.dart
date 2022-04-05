import 'dart:convert';
import 'dart:developer';

import '../usage_criteria.dart';

import 'user_data.dart';

/// Contain token and all user data
class User implements UsageCriteria {
  /// Initializes [token, data] of object.
  const User({this.token, this.data}) : super();

  /// access token
  final String token;

  ///User Data Object
  final UserData data;

  ///copy data from this object and return new object instance
  User copyWith({String token, UserData usermodel}) {
    try {
      return User(
        token: token ?? this.token,
        data: usermodel ?? data,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in User.copyWith : $e');
      return const User();
    }
  }

  /// Named constructor to create object instance from string json data
  factory User.fromJson(String str) {
    if (str == null || str.isEmpty) return const User();

    try {
      return User.fromMap(json.decode(str) as Map<String, dynamic>);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in User.fromJson : $e');
      return const User();
    }
  }

  /// convert object to string json data
  String toJson() => json.encode(toMap());

  /// Named constructor to create object instance from map of data
  factory User.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const User();

      return User(
        token: json['token'] as String,
        data: UserData.fromMap(json['usermodel'] as Map<String, dynamic>),
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in User.fromMap : $e');
      return const User();
    }
  }

  /// convert object to map of data
  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'token': token,
        'usermodel': data?.toMap(),
      };
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in User.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in User.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return token != null && data != null;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in User.usable : $e');
      return false;
    }
  }
}
