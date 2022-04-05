import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:softgrow/module/product/model/filter.dart';

import '../model/helper/product_list_params.dart';
import '../model/product.dart';
import '../model/product_list.dart';
import '../model/variant.dart';
import 'product_repo.dart';

abstract class ProductService {
  const ProductService();

  static Future productList({ProductListParams params}) async {
    try {
      final res = await ProductRepo.productList(params: params);

      if (res.hasError) return res.msg;

      return ProductList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductService.productList : $e');
      return e.toString();
    }
  }

  static Future filter() async {
    try {
      final res = await ProductRepo.filter();

      if (res.hasError) return res.msg;

      return Filter.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductService.filter : $e');
      return e.toString();
    }
  }

  static Future productById(int id) async {
    assert(id != null);

    try {
      final res = await ProductRepo.productById(id);

      if (res.hasError) throw res.msg;

      return Product.fromMap(
        res.json['result']['product'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductService.productById : $e');
      return e.toString();
    }
  }

  static Future variantByAttributes({
    @required int productId,
    @required List<int> attrId,
  }) async {
    assert(productId != null && productId > 0);
    assert(attrId != null && attrId.isNotEmpty);

    try {
      final res = await ProductRepo.getVariantByAttr(
        productId: productId,
        attrId: attrId,
      );

      if (res.hasError) throw res.msg;

      return Variant.fromMap(
        res.json['result']['variant'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductService.variantByAttributes : $e');
      return e.toString();
    }
  }
}
