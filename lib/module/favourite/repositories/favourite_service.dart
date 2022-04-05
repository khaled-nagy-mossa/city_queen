import 'dart:developer';

import 'package:flutter/material.dart';

import '../../product/model/variant_list.dart';
import 'favourite_repo.dart';

abstract class FavouriteService {
  const FavouriteService();

  static Future favorites() async {
    try {
      final res = await FavouriteRepo.favorites();

      if (res.hasError) throw res.msg;

      return VariantList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in FavouriteService.favorites : $e');
      return e.toString();
    }
  }

  static Future<String> addToFavorites({
    @required int variantId,
  }) async {
    assert(variantId != null);

    try {
      final res = await FavouriteRepo.addToFavorites(variantId: variantId);

      if (res.hasError) throw res.msg;

      return null;
    } catch (e) {
      log('Exception in FavouriteService.addToFavorites : $e');
      return e.toString();
    }
  }

  static Future<String> removeFavorites({
    @required int variantId,
  }) async {
    assert(variantId != null);
    try {
      final res = await FavouriteRepo.removeFavorites(variantId: variantId);

      if (res.hasError) return res.msg;

      return null;
    } catch (e) {
      log('Exception in FavouriteService.removeFavorites : $e');
      return e.toString();
    }
  }
}
