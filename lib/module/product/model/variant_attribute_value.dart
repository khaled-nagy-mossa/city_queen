import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class VariantAttributeValue extends UsageCriteria {
  const VariantAttributeValue({this.id, this.name});

  final int id;
  final String name;

  VariantAttributeValue copyWith({
    int id,
    String name,
  }) {
    try {
      return VariantAttributeValue(
        id: id ?? this.id,
        name: name ?? this.name,
      );
    } catch (e) {
      log('Exception in VariantAttributeValue.copyWith : $e');
      return const VariantAttributeValue();
    }
  }

  factory VariantAttributeValue.fromJson(String str) {
    if (str == null || str.isEmpty) return const VariantAttributeValue();
    try {
      return VariantAttributeValue.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in VariantAttributeValue.fromJson : $e');
      return const VariantAttributeValue();
    }
  }

  String toJson() => json.encode(toMap());

  factory VariantAttributeValue.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const VariantAttributeValue();

      return VariantAttributeValue(
        id: json['id'] as int,
        name: json['name'] as String,
      );
    } catch (e) {
      log('Exception in VariantAttributeValue.fromMap : $e');
      return const VariantAttributeValue();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'id': id,
        'name': name,
      };
    } catch (e) {
      log('Exception in VariantAttributeValue.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in VariantAttributeValue.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in VariantAttributeValue.usable : $e');
      return false;
    }
  }
}
