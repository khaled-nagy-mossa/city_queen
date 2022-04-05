import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import '../../category/model/category.dart';
import 'home_view.dart';

class CategoriesCollection extends HomeViewModel implements UsageCriteria {
  const CategoriesCollection({
    this.name,
    this.categories,
  });

  final String name;
  final List<Category> categories;

  CategoriesCollection copyWith({
    String name,
    List<Category> categories,
  }) {
    try {
      return CategoriesCollection(
        name: name ?? this.name,
        categories: categories ?? this.categories,
      );
    } catch (e) {
      log('Exception in CategoriesCollection.copyWith : $e');
      return this;
    }
  }

  factory CategoriesCollection.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const CategoriesCollection();

      return CategoriesCollection.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in CategoriesCollection.fromJson : $e');
      return const CategoriesCollection();
    }
  }

  String toJson() => json.encode(toMap());

  factory CategoriesCollection.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const CategoriesCollection();

      return CategoriesCollection(
        name: json['name'] as String,
        categories: List<Category>.from(
          ((json['categories'] ?? <Map>[]) as List).map<Category>(
              (dynamic x) => Category.fromMap(x as Map<String, dynamic>)),
        ),
      );
    } catch (e) {
      log('Exception in CategoriesCollection.fromMap : $e');
      return const CategoriesCollection();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'name': name,
        'categories': List<dynamic>.from(
          categories?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
      };
    } catch (e) {
      log('Exception in CategoriesCollection.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return name != null && categories != null;
    } catch (e) {
      log('Exception in SliderBanner.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in SliderBanner.unUsable : $e');
      return true;
    }
  }
}
