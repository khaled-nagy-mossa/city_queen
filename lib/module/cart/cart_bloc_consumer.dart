
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/order/order_branch.dart';
import '../../widget/app_dialog/app_dialog.dart';
import '../../widget/app_snack_bar/app_snack_bar.dart';
import 'cubit/cart_cubit.dart';
import 'cubit/cart_states.dart';

class CartBlocConsumer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  //child doing Start doing your thing
  final Widget child;

  const CartBlocConsumer({@required this.navigatorKey, @required this.child})
      : assert(navigatorKey != null),
        assert(child != null);

  BuildContext get _context => navigatorKey.currentState.overlay.context;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<CartCubit, CartStates>(
          listener: (context, state) {
            if (state is ShowAvailableBranchesState) {
              AppDialog.showAvailabilityBranches(
                context: _context,
                branches: state.branches,
                onSelect: (branch) {
                  CartCubit.get(context).branch = OrderBranch(
                    id: branch.branchId,
                    name: branch.branchName,
                  );
                },
              );
            }
            if (state is RemoveBranchState) {
              AppDialog.removeAllBranches(
                context: _context,
                onDelete: () {
                  CartCubit.get(context).clear();
                },
              );
            }
            if (state is VariantAddedState) {
              AppSnackBar.addedToCart(context: _context);
            }
            if (state is EndClearingState) {
              AppSnackBar.clearCart(context: _context);
            }
            if (state is IneffectiveErrorState) {
              AppSnackBar.error(_context, state.error);
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
