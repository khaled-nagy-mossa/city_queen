import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../common/config/api.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../cart/cubit/cart_cubit_extension.dart';
import '../../cart/widget/cart_item.dart';
import '../../global/view/empty_view.dart';
import 'package:get/get.dart';
import '../../payment/view/payment_webview.dart';
import '../cubit/check_order/cubit.dart';
import '../cubit/check_order/states.dart';

class CheckOrderView extends StatelessWidget {
  const CheckOrderView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: BlocProvider<CheckOrderViewCubit>(
        create: (context) => CheckOrderViewCubit(CartCubit.get(context).id),
        child: BlocConsumer<CheckOrderViewCubit, CheckOrderViewStates>(
          listener: (context, state) {
            if (state is IneffectiveErrorState) {
              AppSnackBar.error(context, state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(title: Text('Check Order'.tr)),
              body: _body(context, state),
              floatingActionButton: FloatingActionButton.extended(
                label: const Icon(Icons.send),
                icon: Text('Confirm'.tr),
                onPressed: () => AppRoutes.push(
                  context,
                  PaymentWebView(
                    url: CartCubit.get(context).paymentLink,
                    successUrl: '',
                    onFinish: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, CheckOrderViewStates state) {
    if (state is InitialState || state is RefreshState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Addresses Found!',
        svgPath: Assets.images.location,
        onRefresh: () async {},
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      final cubit = CheckOrderViewCubit.get(context);
      return ListView(
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 100.0),
        children: [
          _title('Reference : ${cubit.order.reference}'.tr),
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Text('Branch'.tr),
              trailing: Text(cubit?.order?.branch?.name ?? ''.tr),
            ),
          ),
          _title('Shipping Address'.tr),
          Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                leading: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        API.imageUrl(cubit?.order?.customer?.image),
                      ),
                    ),
                  ),
                ),
                title: Text(cubit.order.shippingAddress.address),
                subtitle: Text(
                  '${cubit.order.shippingAddress.country.name}/${cubit.order.shippingAddress.state.name}',
                ),
                trailing: Text(
                  cubit?.order?.customer?.phone ?? ''.tr,
                ),
              )),
          _title('Order'.tr),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: CartCubit.get(context).lines.length,
                  itemBuilder: (context, index) {
                    final item = CartCubit.get(context).lines[index];
                    return CartItem(
                      useCounter: false,
                      counter: 0,
                      line: item,
                      onQuantityChanged: (counter) async {
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
            ],
          ),
          _title('Order Details'.tr),
          ListTile(
            title: Text('Status'.tr),
            trailing: Text(cubit.order.status),
          ),
          ListTile(
            title: Text('Payment State'.tr),
            trailing: Text(cubit.order.paymentState),
          ),
          ListTile(
            title: Text('Amount'.tr),
            trailing: Text('${cubit.order.amount}'.tr),
          ),
          ListTile(
            title: Text('Taxes'.tr),
            trailing: Text('${cubit.order.taxes}'.tr),
          ),
          ListTile(
            title: Text('Total'.tr),
            trailing:
                Text('${cubit.order.total} ${cubit.order.currencySymbol}'.tr),
          ),
        ],
      );
    }
  }

  Widget _title(String title) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Text(
              title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Expanded(child: Divider()),
          ],
        ),
      ),
    );
  }
}
