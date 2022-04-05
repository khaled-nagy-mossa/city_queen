import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/api.dart';
import '../model/helper/product_list_params.dart';

abstract class ProductRepo {
  const ProductRepo();

  /// method to get product list
  /// header : Content-Type application/json
  static Future<SuperResponseModel> productList({
    ProductListParams params,
  }) async {
    var url = ProductAPIs.productList;

    if (params != null) {
      url += params.parse;
    }

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  // method to get product list
  // PARAMS : limit=20&offset=0
  // params => productList?limit=20&offset=0
  // header : Content-Type application/json
  static Future<SuperResponseModel> productById(int id) async {
    assert(id != null);

    final url = '${ProductAPIs.getProduct}?product_id=$id';

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  static Future<SuperResponseModel> filter()async {
    return HttpHelper.simpleRequest(HttpHelper.post(
      HttpHelper.url(ProductAPIs.filterParams),
      header: await API.header(),
      body: json.encode({}),
    ));
  }

  //-- Variant --//
  // method to get variant by product id and attributes id
  // PARAMS : getVariantByAttrUrl?product_id=5
  // header : Content-Type application/json
  static Future<SuperResponseModel> getVariantByAttr({
    @required int productId,
    @required List<int> attrId,
  }) async {
    assert(productId != null && productId > 0);
    assert(attrId != null && attrId.isNotEmpty);

    final url = '${ProductAPIs.getVariantByAttr}?product_id=$productId';

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
      body: json.encoder.convert({'attr_ids': attrId}),
    ));
  }
}
