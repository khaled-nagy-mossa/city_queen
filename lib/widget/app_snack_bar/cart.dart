import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../module/cart/view/cart.dart';
import 'app_snack_bar.dart';

abstract class CartSnackBars {
  const CartSnackBars();

  static SnackBar addedToCart(BuildContext context) {
    return SnackBar(
      content: const Text('Added Successfully'),
      action: SnackBarAction(
        label: 'Cart',
        onPressed: () async {
          await AppRoutes.push(context, CartView());
          AppSnackBar.hideSnackBar(context);
        },
      ),
    );
  }

  static SnackBar clearCart(BuildContext context) {
    return SnackBar(
      content: const Text('Cart Cleared Successfully'),
      action: SnackBarAction(
        label: 'Cart',
        onPressed: () async {
          await AppRoutes.push(context, CartView());
          AppSnackBar.hideSnackBar(context);
        },
      ),
    );
  }
}
