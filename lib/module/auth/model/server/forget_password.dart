import 'dart:convert';
import 'dart:developer';

import '../../../../model/usage_criteria.dart';

class ForgetPassword implements UsageCriteria {
  const ForgetPassword({this.result, this.message});

  final bool result;
  final String message;

  ForgetPassword copyWith({bool result, String message}) {
    try {
      return ForgetPassword(
        result: result ?? this.result,
        message: message ?? this.message,
      );
    } catch (e) {
      log('Exception in ForgetPassword.copyWith : $e');
      return const ForgetPassword();
    }
  }

  factory ForgetPassword.fromJson(String str) {
    if (str == null || str.isEmpty) return const ForgetPassword();
    try {
      return ForgetPassword.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ForgetPassword.fromJson : $e');
      return const ForgetPassword();
    }
  }

  String toJson() => json.encode(toMap());

  factory ForgetPassword.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const ForgetPassword();

      return ForgetPassword(
        result: json['result'] as bool,
        message: json['message'] as String,
      );
    } catch (e) {
      log('Exception in ForgetPassword.fromMap : $e');
      return const ForgetPassword();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{'result': result, 'message': message};
    } catch (e) {
      log('Exception in ForgetPassword.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ForgetPassword.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return result != null && message != null;
    } catch (e) {
      log('Exception in ForgetPassword.unUsable : $e');
      return false;
    }
  }
}
