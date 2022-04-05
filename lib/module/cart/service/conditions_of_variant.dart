import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../model/order/extension/order_extension.dart';
import '../../product/model/extension/variant_extension.dart';
import '../../product/model/variant.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_cubit_extension.dart';

class NotAvailableInAnyBranch extends ConditionsOfVariant {}

//Available in a branch other than the one in the shopping cart
class AvailableInAnotherBranchCart extends ConditionsOfVariant {}

class SmallAmount extends ConditionsOfVariant {}

abstract class ConditionsOfVariant {
  static Object analyzing({
    @required Variant variant,
    @required CartCubit cubit,
  }) {
    assert(variant != null);
    assert(cubit != null);

    try {
      if (_notAvailableInAny(variant)) {
        return NotAvailableInAnyBranch();
      } else if (!_haveSameCartBranch(cubit, variant)) {
        return AvailableInAnotherBranchCart();
      } else if (_maxDemandReached(cubit, variant)) {
        return SmallAmount();
      } else {
        return null;
      }
    } catch (e) {
      log('Exception in ConditionsOfVariant : $e');
      return e.toString();
    }
  }

  static bool _notAvailableInAny(Variant variant) {
    try {
      return variant?.notAvailableBranch == true;
    } catch (e) {
      log('Exception in ConditionsOfVariant._notAvailableInAny : $e');
      return true;
    }
  }

  static bool _haveSameCartBranch(CartCubit cartCubit, Variant variant) {
    try {
      if (cartCubit == null || cartCubit.id == null) return true;

      if (!cartCubit.order.branchHasBeenDetermined) return true;

      return variant.containBranchId(cartCubit?.branchId);
    } catch (e) {
      log('Exception in ConditionsOfVariant._haveSameCartBranch : $e');
      return false;
    }
  }

  static bool _maxDemandReached(CartCubit cubit, Variant variant) {
    try {
      if (cubit == null || cubit.id == null) return false;

      final q = cubit.variantQuantity(variant.id);

      return maxDefaultVariantQuantity(cubit, variant) <= q;
    } catch (e) {
      log('Exception in ConditionsOfVariant._maxDemandReached : $e');
      return true;
    }
  }

  static int maxDefaultVariantQuantity(CartCubit cubit, Variant variant) {
    try {
      if (cubit == null || cubit.id == null) return 1; //to enable counter

      final currentSelectedBranch =
          variant.findBranchInAvailableVariantBranches(cubit.branchId);

      if (currentSelectedBranch == null) return 0;

      return currentSelectedBranch.quantity.toInt();
    } catch (e) {
      log('Exception in ConditionsOfVariant._maxDefaultVariantQuantity : $e');
      return 0;
    }
  }
}
