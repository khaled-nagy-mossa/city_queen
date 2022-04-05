import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class StateLocation implements UsageCriteria {
  const StateLocation({this.id, this.name});

  final int id;
  final String name;

  StateLocation copyWith({int id, String name}) {
    try {
      return StateLocation(
        id: id ?? this.id,
        name: name ?? this.name,
      );
    } catch (e) {
      log('Exception in StateLocation.copyWith : $e');
      return this;
    }
  }

  factory StateLocation.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const StateLocation();

      return StateLocation.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in StateLocation.fromJson : $e');
      return const StateLocation();
    }
  }

  String toJson() => json.encode(toMap());

  factory StateLocation.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const StateLocation();

      return StateLocation(
        id: json['id'] as int,
        name: json['name'] as String,
      );
    } catch (e) {
      log('Exception in StateLocation.fromMap : $e');
      return const StateLocation();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'id': id,
        'name': name,
      };
    } catch (e) {
      log('Exception in StateLocation.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in StateLocation.toMap : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in StateLocation.toMap : $e');
      return true;
    }
  }
}
