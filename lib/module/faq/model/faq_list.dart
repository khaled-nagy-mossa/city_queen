import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'faq.dart';

class FaqList implements UsageCriteria {
  const FaqList({
    this.count,
    this.items,
  });

  final int count;
  final List<Faq> items;

  FaqList copyWith({
    int count,
    List<Faq> data,
  }) {
    try {
      return FaqList(
        count: count ?? this.count,
        items: data ?? items,
      );
    } catch (e) {
      log('Exception in FaqList.copyWith : $e');
      return this;
    }
  }

  factory FaqList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const FaqList();

      return FaqList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in FaqList.copyWith : $e');
      return const FaqList();
    }
  }

  String toJson() => json.encode(toMap());

  factory FaqList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const FaqList();

      return FaqList(
        count: json['count'] as int,
        items: List<Faq>.from(
          ((json['data'] ?? <Map>[]) as List).map<Faq>(
            (dynamic x) => Faq.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in FaqList.fromMap : $e');
      return const FaqList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'count': count,
        'data': List<dynamic>.from(
            items?.map<Map>((x) => x?.toMap() ?? <String, dynamic>{})),
      };
    } catch (e) {
      log('Exception in FaqList.toMap : $e');
      return const <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in FaqList.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return count != null && count > 0 && items != null;
    } catch (e) {
      log('Exception in FaqList.usable : $e');
      return false;
    }
  }
}
