import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/order/extension/order_extension.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../../widget/simple_counter.dart';
import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/cubit_extension.dart';
import '../../auth/cubit/auth/states.dart';
import 'package:get/get.dart';
import '../../product/model/variant.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_cubit_extension.dart';
import '../cubit/cart_states.dart';
import '../service/conditions_of_variant.dart';

//ignore: must_be_immutable
class AddToCartBottomNavBar extends StatelessWidget {
  final Variant variant;
  final void Function(int q) onAddToCart;

  AddToCartBottomNavBar({
    @required this.variant,
    @required this.onAddToCart,
  }) : assert(onAddToCart != null);

  int _counter = 0;

  static const _btmConstraints = BoxConstraints(maxHeight: 55.0);
  static const EdgeInsets _padding =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    if (variant == null) return const SizedBox();

    final cubit = CartCubit.get(context);
    _counter = cubit?.variantQuantity(variant.id) ?? 0;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AuthCubit?.get(context)?.signed != true) return const SizedBox();
        return BlocConsumer<CartCubit, CartStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              color: Colors.red,
              height: 60.0,
              child: _body(context, cubit, state),
            );
          },
        );
      },
    );
  }

  Widget _body(BuildContext context, CartCubit cartCubit, CartStates state) {
    final obj = ConditionsOfVariant.analyzing(
      variant: variant,
      cubit: cartCubit,
    );

    if (obj is String) {
      return Container();
    } else if (obj is NotAvailableInAnyBranch) {
      return _notAvailableBranchBtn(context, state);
    } else if (obj is AvailableInAnotherBranchCart) {
      return _availableInAnotherBranchBtn(context, state);
    } else if (obj is SmallAmount) {
      return _defaultButton(context, state);
    } else {
      return _defaultButton(context, state);
    }
  }

  Widget _shadow({@required Widget child}) {
    return Container(
      constraints: const BoxConstraints.tightForFinite(),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.1,
            blurRadius: 7,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _navBarCover({@required Widget child}) {
    return _shadow(
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          padding: _padding,
          constraints: _btmConstraints,
          child: child,
        ),
      ),
    );
  }

  Widget _notAvailableBranchBtn(BuildContext context, CartStates state) {
    return _navBarCover(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Not Available'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          ElevatedButton(
            onPressed: null,
            child: Text('Add To Cart'.tr),
          ).toGradient(context),
        ],
      ),
    );
  }

  Widget _availableInAnotherBranchBtn(BuildContext context, CartStates state) {
    return _navBarCover(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: Text(
                  'Available In Another Branch'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              CartCubit.get(context).notifyClear();
            },
            child: Text('Clear Cart'.tr),
          ).toGradient(context),
        ],
      ),
    );
  }

  Widget _defaultButton(BuildContext context, CartStates state) {
    return _navBarCover(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SimpleCounter(
            counter: _counter,
            counterColor: Colors.red,
            maxCount: ConditionsOfVariant.maxDefaultVariantQuantity(
              CartCubit.get(context),
              variant,
            ),
            onChanged: (c) async {
              return _onCounterChanged(context, c);
            },
          ),
          ElevatedButton(
            onPressed: () async {
              final cubit = CartCubit?.get(context);
              final variantQuantity = cubit?.variantQuantity(variant.id);
              final qty = _counter - variantQuantity ?? 0;
              await cubit.addVariantToCart(variant: variant, quantity: qty);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(160.0, 45.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.add_shopping_cart),
                const SizedBox(width: 10.0),
                Text('Add To Cart'.tr),
              ],
            ),
          ).toGradient(context),
        ],
      ),
    );
  }

  //on Counter Change check if user has been select branch or not
  //if not select branch show  dialog to select branch
  //if he selected _productQuantity will change
  Future<bool> _onCounterChanged(BuildContext context, int counter) async {
    if (CartCubit.get(context).order.branchHasBeenDetermined) {
      _counter = counter;
      return true;
    } else {
      await CartCubit.get(context).addVariantToCart(
        variant: variant,
        quantity: 1,
      );
      return false;
    }
  }
}
//Future<void> _addToCart(CartCubit cubit) async {
//     final variantQuantity = cubit?.variantQuantity(variant.id);
//     final qty = _counter - variantQuantity ?? 0;
//     // onAddToCart(cubit.addVariantToCart(variant: variant, quantity: qty));
//   }
