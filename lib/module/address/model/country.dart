import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class Country implements UsageCriteria {
  const Country({this.id, this.name, this.code});

  final int id;
  final String name;
  final String code;

  Country copyWith({int id, String name, String code}) {
    try {
      return Country(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
      );
    } catch (e) {
      log('Exception in Country.copyWith : $e');
      return this;
    }
  }

  factory Country.fromJson(String str) {


    try {
      if (str == null || str.isEmpty) return const Country();

      return Country.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Country.fromJson : $e');
      return const Country();
    }
  }

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Country();

      return Country(
        id: json['id'] as int,
        name: json['name'] as String,
        code: json['code'] as String,
      );
    } catch (e) {
      log('Exception in Country.fromMap : $e');
      return const Country();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'id': id,
        'name': name,
        'code': code,
      };
    } catch (e) {
      log('Exception in Country.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Country.toMap : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null && code != null;
    } catch (e) {
      log('Exception in Country.toMap : $e');
      return true;
    }
  }
}
