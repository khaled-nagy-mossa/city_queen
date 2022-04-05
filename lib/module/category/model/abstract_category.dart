import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class AbstractCategory implements UsageCriteria {
  const AbstractCategory({
    this.id,
    this.parentCategoryId,
    this.name,
    this.pathName,
    this.image,
  });

  final int id;
  final int parentCategoryId;
  final String name;
  final String pathName;
  final String image;

  AbstractCategory copyWith({
    int id,
    int parentCategoryId,
    String name,
    String pathName,
    String image,
  }) {
    try {
      return AbstractCategory(
        id: id ?? this.id,
        parentCategoryId: parentCategoryId ?? this.parentCategoryId,
        name: name ?? this.name,
        pathName: pathName ?? this.pathName,
        image: image ?? this.image,
      );
    } catch (e) {
      log('Exception in AbstractCategory.copyWith : $e');
      return this;
    }
  }

  factory AbstractCategory.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const AbstractCategory();

      return AbstractCategory.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in AbstractCategory.fromJson : $e');
      return const AbstractCategory();
    }
  }

  String toJson() => json.encode(toMap());

  factory AbstractCategory.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const AbstractCategory();

      return AbstractCategory(
        id: json['id'] as int,
        parentCategoryId: json['parent_category_id'] as int,
        name: json['name'] as String,
        pathName: json['path_name'] as String,
        image: json['image'] as String,
      );
    } catch (e) {
      log('Exception in AbstractCategory.fromMap : $e');
      return const AbstractCategory();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return<String ,dynamic> {
        'id': id,
        'parent_category_id': parentCategoryId,
        'name': name,
        'path_name': pathName,
        'image': image,
      };
    } catch (e) {
      log('Exception in AbstractCategory.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in AbstractCategory.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in AbstractCategory.unUsable : $e');
      return true;
    }
  }
}
