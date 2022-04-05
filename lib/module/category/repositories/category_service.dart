import 'dart:developer';

import '../model/category.dart';
import '../model/category_list.dart';
import '../model/helper/category_list_params.dart';
import 'category_repo.dart';

abstract class CategoryService {
  const CategoryService();

  static Future categoryList({CategoryListParams params}) async {
    try {
      final res = await CategoryRepo.categoryList(params: params);

      if (res.hasError) throw res.msg;

      return CategoryList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in CategoryService.categoryList : $e');
      return e.toString();
    }
  }

  static Future categoryById(int id) async {
    assert(id != null && id > 0);

    try {
      final res = await CategoryRepo.getCategory(id);

      if (res.hasError) throw res.msg;

      return Category.fromMap(
          res.json['result']['category'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in CategoryService.categoryById : $e');
      return e.toString();
    }
  }
}
