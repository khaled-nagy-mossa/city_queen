import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'variant.dart';

class VariantList extends UsageCriteria {
  const VariantList({this.count, this.variants});

  final int count;
  final List<Variant> variants;

  VariantList copyWith({int count, List<Variant> variants}) {
    try {
      return VariantList(
        count: count ?? this.count,
        variants: variants ?? this.variants,
      );
    } catch (e) {
      log('Exception in VariantList.copyWith : $e');
      return const VariantList();
    }
  }

  factory VariantList.fromJson(String str) {
    if (str == null || str.isEmpty) return const VariantList();

    try {
      return VariantList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in VariantList.fromJson : $e');
      return const VariantList();
    }
  }

  String toJson() => json.encode(toMap());

  factory VariantList.fromMap(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return const VariantList();

    try {
      return VariantList(
        count: (json['variants'] ?? <Map>[])?.length as int,
        variants: List<Variant>.from(
          ((json['variants'] ?? <Map>[]) as List).map<Variant>(
              (dynamic x) => Variant.fromMap(x as Map<String, dynamic>)),
        ),
      );
    } catch (e) {
      log('Exception in VariantList.fromMap : $e');
      return const VariantList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'count': count,
        'variants': List<dynamic>.from(
            variants?.map<Map>((x) => x?.toMap()) ?? <Map>[]),
      };
    } catch (e) {
      log('Exception in VariantList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return count != null && variants != null;
    } catch (e) {
      log('Exception in VariantList.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in VariantList.unUsable : $e');
      return true;
    }
  }
}
