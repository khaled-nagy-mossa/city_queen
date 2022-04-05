import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class EditProfileModel implements UsageCriteria {
  const EditProfileModel({this.name, this.email, this.phone});

  final String name;
  final String email;
  final String phone;

  EditProfileModel copyWith({String name, String email, String phone}) {
    try {
      return EditProfileModel(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );
    } catch (e) {
      log('Exception in EditProfileModel.copyWith : $e');
      return this;
    }
  }

  factory EditProfileModel.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const EditProfileModel();

      return EditProfileModel.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in EditProfileModel.fromJson : $e');
      return const EditProfileModel();
    }
  }

  String toJson() => json.encode(toMap());

  factory EditProfileModel.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) {
        return const EditProfileModel();
      }

      return EditProfileModel(
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
      );
    } catch (e) {
      log('Exception in EditProfileModel.fromMap : $e');
      return const EditProfileModel();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
      };
    } catch (e) {
      log('Exception in EditProfileModel.toMap : $e');
      return <String ,dynamic> {};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in EditProfileModel.unusable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return name != null && email != null;
    } catch (e) {
      log('Exception in EditProfileModel.usable : $e');
      return false;
    }
  }
}
