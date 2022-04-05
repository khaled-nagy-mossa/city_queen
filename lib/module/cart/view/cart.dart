import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';

import '../../../common/assets/assets.dart';
import '../../../model/order/extension/order_extension.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../address/model/address.dart';
import '../../address/view/user_addresses_view.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/cubit_extension.dart';
import '../../global/view/empty_view.dart';
import '../../home/view/home.dart';
import 'package:get/get.dart';
import '../../payment/view/payment_webview.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_cubit_extension.dart';
import '../cubit/cart_states.dart';
import '../widget/cart_item.dart';

class CartView extends StatelessWidget {
  static const String id = 'cart_view';

  Future<void> _goToSelectAddress(BuildContext context) async {
    try {
      await AppRoutes.push(
        context,
        UserAddressesView(
          title: 'Choose Address'.tr,
          onSelect: (address) {
            if (address != null) {
              Navigator.pop(context);
              _goToPaymentView(context, address);
            }
          },
        ),
      );
    } catch (e) {
      log('Exception in CartView._selectAddressAndGoToPaymentView : $e'.tr);
      AppSnackBar.error(context, e.toString());
    }
  }

  Future<void> _goToPaymentView(BuildContext context, Address address) async {
    final cubit = CartCubit.get(context);
    print("${cubit.paymentLink}");
    await cubit.updateOrderAddress(address.id);

    await AppRoutes.push(
      context,
      PaymentWebView(
        successUrl: 'https://upsale.app/ar/website_payment/confirm',
        url: cubit.paymentLink,
        onFinish: () {
          log('Done Ya 3azizy'.tr);

          AppRoutes.pushAndRemoveUntil(context, const HomeView());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (AuthCubit?.get(context)?.signed == true) {
      CartCubit.get(context).refresh();
    }

    return AuthListener(
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if (state is IneffectiveErrorState) {
            AppSnackBar.error(context, state.error);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text('Cart View'.tr,
                      style: TextStyle(color: Colors.grey[800])),
                ),
                body: _body(context, state),
              ),
              if (state is RefreshState ||
                  state is StartClearingState ||
                  state is LoadingState)
                const LoadingWidget(),
            ],
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, CartStates state) {
    final cubit = CartCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Products Found!'.tr,
        svgPath: Assets.images.cart,
        onRefresh: () async {
          await cubit?.refresh();
        },
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.e));
    } else {
      if (cubit.isEmpty) {
        return EmptyView(
          title: 'No Products Found!'.tr,
          svgPath: Assets.images.cart,
          onRefresh: () async {
            await CartCubit.get(context).refresh();
          },
        );
      }
      return ListView(
        padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 70.0),
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 7.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit?.lines?.length ?? 0,
              itemBuilder: (context, index) {
                final line = cubit.lines[index];
                return CartItem(
                  counter: cubit.variantQuantity(line.variantId),
                  line: line,
                  onQuantityChanged: (counter) async {
                    await cubit.changeLineQuantity(line, counter - line.qty);
                    return true;
                  },
                  onDelete: () {},
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 20.0, endIndent: 20.0);
              },
            ),
          ),
          if (CartCubit.get(context).order.hasLines) ...[
            const SizedBox(height: 60.0),
            ListTile(
              title: Text(
                'Subtotal'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '${cubit.order.currencySymbol}${cubit.order.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Taxes'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '${cubit.order.currencySymbol}${cubit.order.taxes}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const Divider(thickness: 2.0),
            ListTile(
              title: Text(
                '${'Total'.tr}:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '${cubit.order.currencySymbol}${cubit.order.total}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                _goToSelectAddress(context);
              },
              child: Text('Check Out'.tr),
            ).toGradient(context),
            const SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () async {
                await cubit.clear();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text(
                'Clear Cart'.tr,
                style: const TextStyle(color: Colors.black),
              ),
            ).toGradient(context),
          ],
        ],
      );
    }
  }
}
