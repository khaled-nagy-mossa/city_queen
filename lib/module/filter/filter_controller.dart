import 'package:get/get.dart';
import 'package:softgrow/module/category/model/category.dart';
import 'package:softgrow/module/product/cubit/filter/states.dart';
import 'package:softgrow/module/product/model/filter.dart';
import 'package:softgrow/module/product/model/helper/product_list_params.dart';
import 'package:softgrow/module/product/model/product_list.dart';
import 'package:softgrow/module/product/repositories/product_service.dart';

class FilterController extends GetxController {
  @override
  void onInit() {
    changeFilterStatus(false);
    fetchData();
    super.onInit();
  }

  bool isFilter = false;
  void changeFilterStatus(bool filter) {
    isFilter = filter;
    update();
  }

  // loading event
  bool isLoading = false;
  void loadingEvent(bool loading) {
    isLoading = loading;
  }

  //////////////////

  Filter filter;
  ProductList productList;
  int categoryId;
  int selectedValue;
  bool value = false;
  void selecteCategory(int categoryIndex, int id) {
    selectedValue = categoryIndex;
    categoryId = id;
    update();
  }

  void selecteCheckBox(bool v) {
    value = v;
    update();
  }

  List<int> selectedIds = [];

  set selecteIds(List<int> ids) {
    selectedIds = ids ?? [];
    print("list of ids : $selectedIds");
    update();
  }

  bool fun(FilterAttribute attribute) {
    for (final valueIds in attribute.valueIds) {
      if (selectedIds.contains(valueIds.id)) {
        return true;
      }
    }

    return false;
  }

  void addId(int id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    print("list of ids : $selectedIds");
    update();
  }

  Future<void> fetchData() async {
    loadingEvent(true);
    try {
      final result = await ProductService.filter();
      if (result is Filter) {
        filter = result;
        print("filter resualt is : ${filter.categories.length}");
      } else {
        throw result;
      }
      loadingEvent(false);
      update();
    } catch (e) {
      print("error is $e");
    }
  }

  Future<void> fetchProductsFiltred() async {
    loadingEvent(true);
    try {
      final result = await ProductService.productList(
          params: ProductListParams(
              attrsValueIds: selectedIds, categoryId: categoryId));
      if (result is ProductList) {
        productList = result;
        print("product filtered resualt is : ${productList.products}");
      } else {
        throw result;
      }
      loadingEvent(false);
      update();
    } catch (e) {
      print("error is $e");
    }
  }

// ignore: eol_at_end_of_file
}
