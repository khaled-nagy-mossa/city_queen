import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'product_attribute_value.dart';

class ProductAttribute implements UsageCriteria {
  const ProductAttribute({
    this.id,
    this.name,
    this.type,
    this.values,
  });

  final int id;
  final String name;
  final String type;
  final List<ProductAttributeValue> values;

  ProductAttribute copyWith({
    int id,
    String name,
    String type,
    List<ProductAttributeValue> values,
  }) {
    try {
      return ProductAttribute(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        values: values ?? this.values,
      );
    } catch (e) {
      log('Exception in ProductAttribute.copyWith : $e');
      return const ProductAttribute();
    }
  }

  factory ProductAttribute.fromJson(String str) {
    if (str == null || str.isEmpty) return const ProductAttribute();

    try {
      return ProductAttribute.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductAttribute.fromJson : $e');
      return const ProductAttribute();
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductAttribute.fromMap(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return const ProductAttribute();

    try {
      return ProductAttribute(
        id: json['id'] as int,
        name: json['name'] as String,
        type: json['type'] as String,
        values: List<ProductAttributeValue>.from(
          ((json['values'] ?? <Map>[]) as List).map<ProductAttributeValue>(
            (dynamic x) =>
                ProductAttributeValue.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in ProductAttribute.fromMap : $e');
      return const ProductAttribute();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'type': type,
        'values': List<dynamic>.from(values?.map<Map>((x) => x?.toMap())),
      };
    } catch (e) {
      log('Exception in ProductAttribute.toMap : $e');
      return const <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ProductAttribute.usable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && values != null && values.isNotEmpty;
    } catch (e) {
      log('Exception in ProductAttribute.usable : $e');
      return false;
    }
  }
}
