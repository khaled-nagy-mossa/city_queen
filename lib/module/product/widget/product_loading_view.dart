import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../widget/loading_widget.dart';
import '../../cart/cubit/cart_states.dart' as cart_states;
import '../cubit/product/product_states.dart';
import '../cubit/variant/variant_states.dart' as variant_states;

class ProductLoadingView extends StatelessWidget {
  final ProductViewStates state;
  final cart_states.CartStates cState;
  final variant_states.VariantStates vState;

  const ProductLoadingView({
    @required this.state,
    @required this.cState,
    @required this.vState,
  });

  @override
  Widget build(BuildContext context) {
    try {
      if (vState is variant_states.LoadingVariantState ||
          state is LoadingState ||
          cState is cart_states.AddingVariantState) {
        return const LoadingWidget();
      }
      return const SizedBox();
    } catch (e) {
      log('Exception in ProductLoadingView : ${e.toString()}');
      return const SizedBox();
    }
  }
}
