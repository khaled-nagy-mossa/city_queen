import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/auth_observer/auth_middle_ware.dart';
import 'package:get/get.dart';
import '../../product/model/product.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_states.dart';
import '../service/conditions_of_variant.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;

  const AddToCartButton({@required this.product});

  static const _btnConstraints =
      BoxConstraints(maxHeight: 38.0, maxWidth: 38.0);

  static const _btnPadding = EdgeInsets.all(7.0);

  @override
  Widget build(BuildContext context) {
    if (product == null || product.defaultVariant == null) {
      return const SizedBox();
    }

    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        try {
          return GestureDetector(
            onTap: () {
              authMiddleWare(
                context: context,
                action: () async {
                  await CartCubit.get(context).addVariantToCart(
                    variant: product?.defaultVariant,
                    quantity: 1,
                  );
                },
              );
            },
            child: _body(context, CartCubit.get(context), state),
          );
        } catch (e) {
          return const SizedBox();
        }
      },
    );
  }

  Widget _body(BuildContext context, CartCubit cartCubit, CartStates state) {
    final obj = ConditionsOfVariant.analyzing(
      variant: product.defaultVariant,
      cubit: cartCubit,
    );
    if (obj is String) {
      return Container();
    } else if (obj is NotAvailableInAnyBranch) {
      return _notAvailableBranchBtn(state);
    } else if (obj is AvailableInAnotherBranchCart) {
      return _availableInAnotherBranchBtn(state);
    } else if (obj is SmallAmount) {
      return _smallAmountBtn(state);
    } else {
      return _defaultButton(context, state);
    }
  }

  Widget _notAvailableBranchBtn(CartStates state) {
    return Tooltip(
      message: 'Not Available in any branch'.tr,
      child: Container(
        padding: _btnPadding,
        constraints: _btnConstraints,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: _borderRadius,
        ),
        child: _addIcon(Colors.white, state),
      ),
    );
  }

  Widget _availableInAnotherBranchBtn(CartStates state) {
    return Tooltip(
      message: 'Available In Another Branch\nclear cart to add this product',
      child: Container(
        padding: _btnPadding,
        constraints: _btnConstraints,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: _borderRadius,
        ),
        child: _addIcon(Colors.white, state),
      ),
    );
  }

  Widget _smallAmountBtn(CartStates state) {
    return Tooltip(
      message: 'small amount'.tr,
      child: Container(
        padding: _btnPadding,
        constraints: _btnConstraints,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: _borderRadius,
        ),
        child: _addIcon(Colors.white, state),
      ),
    );
  }

  Widget _defaultButton(BuildContext context, CartStates state) {
    return Tooltip(
      message: 'available'.tr,
      child: Container(
        padding: _btnPadding,
        constraints: _btnConstraints,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: _borderRadius,
        ),
        child: _addIcon(Colors.white, state),
      ),
    );
  }

  BorderRadius get _borderRadius {
    return const BorderRadius.only(
      topLeft: Radius.circular(500.0),
      bottomLeft: Radius.circular(500.0),
    );
  }

  Widget _addIcon(Color iconColor, CartStates state) {
    // return SvgPicture.asset(
    //   Assets.images.add_cart,
    //   color: Colors.white,
    //   height: 20.0,
    // );
    try {
      if (state is AddingVariantState &&
          state?.variant?.id == product?.defaultVariant?.id) {
        return Container(
          constraints: const BoxConstraints(),
          child: const CircularProgressIndicator(color: Colors.white),
        );
      }
      return Icon(Icons.add_shopping_cart, color: iconColor);
    } catch (e) {
      log('Exception in AddToCartButton._addIcon : $e'.tr);
      return Icon(Icons.add_shopping_cart, color: iconColor);
    }

    // return Icon(Icons.add, color: iconColor);
  }
}
