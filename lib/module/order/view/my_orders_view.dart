import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/auth_observer/auth_builder.dart';
import 'package:get/get.dart';
import '../controller/const.dart';
import '../cubit/type_of_order_screen_cubit/cubit.dart';
import '../model/orders_param.dart';
import 'type_of_orders_view.dart';

class MyOrdersView extends StatefulWidget {
  static const id = 'my_orders_view';

  const MyOrdersView();

  @override
  _MyOrdersViewState createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabs = OrderStagesHelper.orderTypeTabs
      .map((e) => Tab(child: Text(e.title)))
      .toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Orders'.tr, style: TextStyle(color: Colors.grey[800])),
          bottom: TabBar(
            controller: _tabController,
            tabs: _tabs,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: OrderStagesHelper.orderTypeTabs.map((e) {
            return BlocProvider<TypeOfOrdersViewCubit>(
              create: (context) {
                return TypeOfOrdersViewCubit(OrdersListParam(
                  orderTypeParameter: e.orderTypeParameter,
                ));
              },
              child: TypeOfOrdersScreen(orderTypeTab: e),
            );
          }).toList(),
        ),
      ),
    );
  }
}
