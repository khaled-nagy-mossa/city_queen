import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'abstract_category.dart';

class Category implements UsageCriteria {
  const Category({
    this.id,
    this.name,
    this.pathName,
    this.parentCategory,
    this.description,
    this.image,
    this.banner,
  });

  final int id;
  final String name;
  final String pathName;
  final AbstractCategory parentCategory;
  final String description;
  final String image;
  final List<String> banner;

  Category copyWith({
    int id,
    String name,
    String pathName,
    AbstractCategory parentCategory,
    String description,
    String image,
    List<String> banner,
  }) {
    try {
      return Category(
        id: id ?? this.id,
        name: name ?? this.name,
        pathName: pathName ?? this.pathName,
        parentCategory: parentCategory ?? this.parentCategory,
        description: description ?? this.description,
        image: image ?? this.image,
        banner: banner ?? this.banner,
      );
    } catch (e) {
      log('Exception in Category.copyWith : $e');
      return this;
    }
  }

  factory Category.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const Category();

      return Category.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Category.fromJson : $e');
      return const Category();
    }
  }

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Category();

      return Category(
        id: json['id'] as int,
        name: json['name'] as String,
        pathName: json['path_name'] as String,
        parentCategory: AbstractCategory.fromMap(
          json['parent_category'] as Map<String, dynamic>,
        ),
        description: json['description'] as String,
        image: json['image'] as String,
        banner: List<String>.from(
          ((json['banner'] ?? <String>[]) as List)
              .map<String>((dynamic x) => x as String),
        ),
      );
    } catch (e) {
      int id;
      if (json != null) id = json['id'] as int;

      log('Exception in Category.fromMap id : $id => $e');
      return const Category();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'path_name': pathName,
        'parent_category': parentCategory?.toMap(),
        'description': description,
        'image': image,
        'banner':
            List<dynamic>.from(banner?.map<String>((x) => x) ?? <String>[]),
      };
    } catch (e) {
      log('Exception in Category.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in Category.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Category.usable : $e');
      return true;
    }
  }
}
