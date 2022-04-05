import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/app_snack_bar/app_snack_bar.dart';
import 'cubit/favourites_cubit.dart';
import 'cubit/favourites_states.dart';

class FavouriteBlocConsumer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  //child doing Start doing your thing
  final Widget child;

  const FavouriteBlocConsumer(
      {@required this.navigatorKey, @required this.child})
      : assert(navigatorKey != null),
        assert(child != null);

  BuildContext get _context => navigatorKey.currentState.overlay.context;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<FavouritesCubit, FavouritesViewStates>(
          listener: (context, state) {
            if (state is AddedVariantState) {
              AppSnackBar.addedToFavourite(context: _context);
            }
          },
          builder: (context, state) {
            return child;
          },
        );
      },
    );
  }
}
