import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../module/favourite/view/favourites_view.dart';
import 'app_snack_bar.dart';

abstract class FavouriteSnackBars {
  const FavouriteSnackBars();

  static SnackBar addedToList(BuildContext context) {
    return SnackBar(
      content: const Text('Added To Favourite List Successfully'),
      action: SnackBarAction(
        label: 'Favourites',
        onPressed: () async {
          await AppRoutes.push(context, const FavouritesView());
          AppSnackBar.hideSnackBar(context);
        },
      ),
    );
  }

  static SnackBar removedFromList(BuildContext context) {
    return SnackBar(
      content: const Text('Removed From Favourite List Successfully'),
      action: SnackBarAction(
        label: 'Favourites',
        onPressed: () async {
          await AppRoutes.push(context, const FavouritesView());
          AppSnackBar.hideSnackBar(context);
        },
      ),
    );
  }
}
