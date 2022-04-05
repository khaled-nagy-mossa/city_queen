import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../global/view/empty_view.dart';
import '../../global/widget/exception.dart';
import 'package:get/get.dart';
import '../../order/cubit/type_of_order_screen_cubit/cubit.dart';
import '../../order/cubit/type_of_order_screen_cubit/states.dart';
import '../../order/model/order_type_tab_model.dart';
import '../widget/order_items_2.dart';
import 'order_view.dart';

//ignore: must_be_immutable
class TypeOfOrdersScreen extends StatelessWidget {
  static const id = 'type_of_orders_view';

  final OrderTypeTapModel orderTypeTab;

  TypeOfOrdersScreen({@required this.orderTypeTab})
      : assert(orderTypeTab != null);

  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 10) {
        TypeOfOrdersViewCubit.get(context).fetchMore();
      }
    });

    return AuthListener(
      child: Builder(
        builder: (context) {
          return BlocConsumer<TypeOfOrdersViewCubit, TypeOgOrderScreenStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    backgroundColor: Colors.white,
                    body: _body(context, state),
                  ),
                  if (state is LoadingState) const LoadingWidget(),
                  if (state is FetchingDataState) const AppLinearIndicator(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, TypeOgOrderScreenStates state) {
    final cubit = TypeOfOrdersViewCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is ExceptionState) {
      return ExceptionWidget(
        onRefresh: cubit.refresh,
        exceptionMsg: state?.error ?? 'Unknown Exception'.tr,
      );
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Orders Found!'.tr,
        svgPath: Assets.images.orders,
        onRefresh: cubit.refresh,
      );
    } else {
      return RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 70.0),
          itemCount: cubit?.orderList?.orders?.length ?? 0,
          itemBuilder: (context, index) {
            final order = cubit?.orderList?.orders[index];
            return GestureDetector(
              onTap: () {
                AppRoutes.push(context, OrderView(order: order));
              },
              child: OrderDataNode(order: order, type: orderTypeTab.orderType),
            );
            // return OrderItem(order: order, type: orderTypeTab.orderType);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10.0);
          },
        ),
      );
    }
  }
}
