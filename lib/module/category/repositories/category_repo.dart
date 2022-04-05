import 'dart:async';

import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';
import '../model/helper/category_list_params.dart';

abstract class CategoryRepo {
  const CategoryRepo();

  //to get category list and category list by parent id
  // limit => # Optional
  // offset => # Optional
  // parent_id => # Optional
  //params => pagination categoriesUrl?limit=10&offset=0&parent_id=1
  static Future<SuperResponseModel> categoryList({
    CategoryListParams params,
  }) async {
    var url = CategoryAPIs.categoryList;

    if (params != null) {
      url += params.parse;
    }

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  //to get category by id
  //params => getCategory??category_id=11
  static Future<SuperResponseModel> getCategory(int id) async {
    assert(id != null && id > 0);

    final url = '${CategoryAPIs.getCategory}?category_id=$id';

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }
}
