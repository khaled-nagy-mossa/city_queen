import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class ProductAttributeValue implements UsageCriteria {
  const ProductAttributeValue({
    this.id,
    this.name,
    this.displayType,
    this.htmlColor,
  });

  final int id;
  final String name;
  final String displayType;
  final String htmlColor;

  ProductAttributeValue copyWith({
    int id,
    String name,
    String displayType,
    String htmlColor,
  }) {
    try {
      return ProductAttributeValue(
        id: id ?? this.id,
        name: name ?? this.name,
        displayType: displayType ?? this.displayType,
        htmlColor: htmlColor ?? this.htmlColor,
      );
    } catch (e) {
      log('Exception in ProductAttributeValue.copyWith : $e');
      return const ProductAttributeValue();
    }
  }

  factory ProductAttributeValue.fromJson(String str) {
    if (str == null || str.isEmpty) return const ProductAttributeValue();
    try {
      return ProductAttributeValue.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductAttributeValue.fromJson : $e');
      return const ProductAttributeValue();
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductAttributeValue.fromMap(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return const ProductAttributeValue();

    try {
      return ProductAttributeValue(
        id: json['id'] as int,
        name: json['name'] as String,
        displayType: json['display_type'] as String,
        htmlColor: json['html_color'] as String,
      );
    } catch (e) {
      log('Exception in ProductAttributeValue.fromMap : $e');
      return const ProductAttributeValue();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'id': id,
        'name': name,
        'display_type': displayType,
        'html_color': htmlColor,
      };
    } catch (e) {
      log('Exception in ProductAttributeValue.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in ProductAttributeValue.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ProductAttributeValue.unUsable : $e');
      return true;
    }
  }
}
