import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'category.dart';

class CategoryList implements UsageCriteria {
  const CategoryList({this.count, this.categories});

  final int count;
  final List<Category> categories;

  CategoryList copyWith({
    int count,
    List<Category> categories,
  }) {
    try {
      return CategoryList(
        count: count ?? this.count,
        categories: categories ?? this.categories,
      );
    } catch (e) {
      log('Exception in CategoryList.copyWith : $e');
      return this;
    }
  }

  factory CategoryList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const CategoryList();

      return CategoryList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in CategoryList.fromJson : $e');
      return const CategoryList();
    }
  }

  String toJson() => json.encode(toMap());

  factory CategoryList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const CategoryList();

      return CategoryList(
        count: json['count'] as int,
        categories: List<Category>.from(
          ((json['categories'] ?? <Map>[]) as List).map<Category>(
              (dynamic x) => Category.fromMap(x as Map<String, dynamic>)),
        ),
      );
    } catch (e) {
      log('Exception in CategoryList.fromMap : $e');
      return const CategoryList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'count': count,
        'categories': List<dynamic>.from(
          categories?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
      };
    } catch (e) {
      log('Exception in CategoryList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in CategoryList.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return count != null && categories != null;
    } catch (e) {
      log('Exception in CategoryList.unUsable : $e');
      return true;
    }
  }
}
