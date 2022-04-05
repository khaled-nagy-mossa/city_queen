import 'package:flutter/material.dart';

import 'cart.dart';
import 'exception.dart';
import 'favourite.dart';

abstract class AppSnackBar {
  const AppSnackBar();

  static void _show(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  // Cart Snack Bar ############################################################
  static void addedToCart({@required BuildContext context}) {
    _show(context, CartSnackBars.addedToCart(context));
  }

  static void clearCart({@required BuildContext context}) {
    _show(context, CartSnackBars.clearCart(context));
  }

  // Favourite Snack Bar #######################################################
  static void addedToFavourite({@required BuildContext context}) {
    _show(context, FavouriteSnackBars.addedToList(context));
  }

  static void removedFromFavourite({@required BuildContext context}) {
    _show(context, FavouriteSnackBars.removedFromList(context));
  }

  // Exception Snack Bar #######################################################
  static void exception({
    @required BuildContext context,
    @required String errorMsg,
  }) {
    _show(context, ExceptionsSnackBars.normalException(e: errorMsg ?? 'Unknown Exception'));
  }

  static void unKnownException({@required BuildContext context}) {
    _show(context, ExceptionsSnackBars .unknownException());
  }

  static void netWorkException(BuildContext context) {
    _show(context, ExceptionsSnackBars .networkException());
  }

  static void error(BuildContext context, String errorMsg) {
    _show(context, ExceptionsSnackBars .errorSnackBar(context: context, e: errorMsg));
  }
}
