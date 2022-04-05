import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class CartConfig {
  const CartConfig();

  // method to add variant to cart
  // header : Content-Type application/json
  // body => 'branch_id':1 , 'variant_id':43, 'quantity':1
  static Future<SuperResponseModel> addToCart({
    @required int branchId,
    @required int variantId,
    @required int quantity,
  }) async {
    return HttpHelper.simpleRequest(
        HttpHelper.post(HttpHelper.url(CartAPIs.addToCart),
            header: await API.header(),
            body: json.encoder.convert({
              'branch_id': branchId,
              'variant_id': variantId,
              'quantity': quantity,
            })));
  }

  //method to get cart items
  // header : Content-Type application/json
  // body => {}  [you must send  { } in body]
  static Future<SuperResponseModel> getCart() async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(CartAPIs.getCart),
        header: await API.header(),
        body: json.encoder.convert(<String ,dynamic>{})));
  }

  static Future<SuperResponseModel> removeCart() async {
    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(CartAPIs.removeCart),
        header: await API.header(),
        body: json.encoder.convert(<String ,dynamic>{}),
      ),
    );
  }
}
