import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../../../model/order/order.dart';
import 'cart_repo.dart';

abstract class CartService {
  const CartService();

  static Future getCart() async {
    try {
      final res = await CartConfig.getCart();

      if (res.hasError) throw res.msg;

      final temp = res.json['result']['data'] as Map<String, dynamic>;

      if (temp == null || temp['id'] == null) return const Order();

      return Order.fromMap(temp);
    } catch (e) {
      log('Exception in CartService.getCart : $e');
      return e.toString();
    }
  }

  static Future removeCart() async {
    try {
      final res = await CartConfig.removeCart();

      if (res.hasError) return res.msg;

      return res.json;
    } catch (e) {
      log('Exception in CartService.removeCart : $e');
      return e.toString();
    }
  }

  static Future addToCart({
    @required int branchId,
    @required int variantId,
    @required int qty,
  }) async {
    assert(branchId != null);
    assert(variantId != null);
    assert(qty != null);

    try {
      final res = await CartConfig.addToCart(
        branchId: branchId,
        variantId: variantId,
        quantity: qty,
      );

      if (res.hasError) return res.msg;

      return Order.fromMap(res.json['result']['data'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in CartService.addToCart : $e');
      return e.toString();
    }
  }
}
