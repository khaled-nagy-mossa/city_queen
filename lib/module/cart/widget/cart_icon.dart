import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../../model/order/extension/order_extension.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_states.dart';
import '../view/cart.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        return GestureDetector(
          onTap: () {
            AppRoutes.push(context, CartView());
          },
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            constraints: BoxConstraints.tight(const Size(40.0, 40.0)),
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints.tight(const Size(40.0, 40.0)),
                  child: Image.asset(
                    "assets/images/shopping-cart-black.png",
                  ),
                ),
                if (cubit.order.linesLength != 0) _counter(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _counter(BuildContext context) {
    final cubit = CartCubit.get(context);
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          child: Text(
            cubit.order.iItemsLength.toString() ?? 0.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 9.0),
          ),
        ),
      ),
    );
  }
}
