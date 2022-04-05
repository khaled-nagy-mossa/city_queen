import 'dart:developer';

import '../../model/category_list.dart';
import 'categories_cubit.dart';

///helper methods
extension CategoriesCubitExtension on CategoriesViewCubit {
  void initialFromObject(CategoryList initData) {
    if (initData == null) return;

    categoryList = CategoryList(
      count: initData.count,
      categories: initData.categories,
    );
  }

  bool get isEmpty {
    try {
      return categoryList == null ||
          categoryList.count == 0 ||
          categoryList.categories == null ||
          categoryList.categories.isEmpty;
    } catch (e) {
      log('Exception in ProductsCubitExtension.isEmpty : $e');
      return true;
    }
  }

  void resetCubitData() {
    /// comment this to show data in the background in screen
    // filteredProductList = const ProductList();
    // productList = const ProductList();

    resetOffset();
  }

  void increaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? -20) + 20);
  }

  void decreaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? 20) - 20);
  }

  void resetOffset() {
    params = params.copyWith(offset: 0);
  }
}
