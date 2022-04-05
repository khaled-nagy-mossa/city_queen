import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/order/extension/order_extension.dart';
import '../../../model/order/order.dart';
import '../../../model/order/order_branch.dart';
import '../../../model/order/order_line.dart';
import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/states.dart' as auth_states;
import '../../order/repositories/service.dart';
import '../../product/model/variant.dart';
import '../repositories/cart_service.dart';
import '../service/conditions_of_variant.dart';
import 'cart_cubit_extension.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  Order order;
  final AuthCubit authCubit;
  StreamSubscription _streamSubscription;

  CartCubit({@required this.authCubit}) : super(const InitialState()) {
    _streamSubscription = authCubit.stream.listen((event) {
      if (event is auth_states.SignedState) {
        getCart();
      } else if (event is auth_states.SignOutState) {
        clearCache();
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  //to be more easily when use it ..for example just call [CounterCubit.get(context).counter]
  factory CartCubit.get(BuildContext context) {
    return BlocProvider.of<CartCubit>(context);
  }

  Future<void> clearCache() async {
    await Future<void>.delayed(Duration.zero);
    order = const Order();
    emit(const ClearedCacheState());
  }

  Future<void> getCart() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await CartService.getCart();

      if (result is String) throw result;

      if (result is Order) await initialFromObject(result);
    } catch (e) {
      log('Exception in CartCubit.init : $e');
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> initialFromObject(Order order) async {
    await Future<void>.delayed(Duration.zero);

    this.order = order;

    emit(HasUpdatedState(order: this.order));
  }

  Future refresh() async {
    await Future<void>.delayed(Duration.zero);

    emit(const RefreshState());

    await getCart();
  }

  Future<void> changeLineQuantity(OrderLine line, int qty) async {
    try {
      await Future<void>.delayed(Duration.zero);

      emit(const LoadingState());

      if (!haveLine(line.id)) throw 'line not found!';

      final Object result = await CartService.addToCart(
        branchId: branchId,
        variantId: line.variantId,
        qty: qty,
      );

      if (result is String) throw result;

      if (result is Order) {
        if (result.unusable) throw 'unknown error';
        order = result;
      }

      emit(const HasUpdatedState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  /// will change location
  Future<void> updateOrderAddress(int addressId) async {
    assert(addressId != null);

    try {
      await Future<void>.delayed(Duration.zero);
      emit(const LoadingState());

      final Object result = await OrderService.updateOrderAddress(
        orderId: order.id,
        addressId: addressId,
      );

      if (result is String) throw result;

      if (result is Order) {
        order = result;
        emit(const HasUpdatedState());
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> addVariantToCart({
    @required Variant variant,
    @required int quantity,
  }) async {
    assert(variant != null);
    assert(quantity != null);

    await Future<void>.delayed(Duration.zero);
    try {
      final obj = ConditionsOfVariant.analyzing(variant: variant, cubit: this);

      final maxQuantity =
          ConditionsOfVariant?.maxDefaultVariantQuantity(this, variant) ?? 0;

      final currentQuantity = variantQuantity(variant.id);

      if (obj is NotAvailableInAnyBranch) {
        throw 'Not Available In Any Branch';
      } else if (obj is AvailableInAnotherBranchCart) {
        emit(const RemoveBranchState());

        return;
      } else if (obj is SmallAmount &&
          (currentQuantity + quantity) >= maxQuantity) {
        throw 'max quantity';
      } else if (order?.branchHasBeenDetermined == false) {
        //to show dialog to show available branches (in root of application in CartBlocConsumer )

        emit(
          ShowAvailableBranchesState(
              branches: variant.branchesAvailability, order: order),
        );

        return;
      } else {
        emit(AddingVariantState(variant: variant, order: order));

        final Object result = await CartService.addToCart(
            variantId: variant.id, branchId: branchId, qty: quantity);

        if (result is String) throw result;

        if (result is Order) {
          order = result;
          emit(VariantAddedState(variant: variant, order: order));
        }
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> notifyClear() async {
    await Future<void>.delayed(Duration.zero);
    emit(const RemoveBranchState());
  }

  Future<void> clear({bool notify = true}) async {
    try {
      await Future<void>.delayed(Duration.zero);

      emit(StartClearingState(order: order));

      final Object result = await CartService.removeCart();

      if (result is String) throw result;

      order = const Order();

      if (notify) {
        emit(const EndClearingState());
      }
    } catch (e) {
      log('Exception in CartCubit.clear : $e');
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  OrderBranch get branch => order?.branch;

  set branch(OrderBranch branch) {
    order = order.copyWith(branch: branch);
    emit(BranchHasChangedState(branch: branch, order: order));
  }
}
