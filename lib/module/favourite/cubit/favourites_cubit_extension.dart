import 'dart:developer';

import '../../product/model/variant_list.dart';
import 'favourites_cubit.dart';

extension FavouritesCubitExtension on FavouritesCubit {
  bool get hasData {
    return favouriteList != null && favouriteList.usable;
  }

  bool contains(int variantId) {
    try {
      return idContainsList(
        favourites: favouriteList,
        variantId: variantId,
      );
    } catch (e) {
      log('Exception in FavouritesCubit.contains : $e');
      return false;
    }
  }

  static bool idContainsList({VariantList favourites, int variantId}) {
    try {
      if (favourites == null || favourites.unusable) return false;

      for (final variant in favourites.variants) {
        if (variant.id == variantId) {
          return true;
        }
      }

      return false;
    } catch (e) {
      log('Exception in FavouriteService.idContainsList : $e');
      return false;
    }
  }
}
