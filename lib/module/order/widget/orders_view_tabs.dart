import 'package:flutter/material.dart';

import '../controller/const.dart';
import '../model/order_type_tab_model.dart';
import 'order_tap.dart';

class OrdersViewTabs extends StatelessWidget {
  final OrderTypeTapModel selectedModel;
  final void Function(OrderTypeTapModel model, int index) onSelectTab;

  const OrdersViewTabs({
    @required this.selectedModel,
    @required this.onSelectTab,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 40.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: OrderStagesHelper.orderTypeTabs.length,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 20.0);
          },
          itemBuilder: (context, index) {
            final model = OrderStagesHelper.orderTypeTabs[index];
            return OrderTap(
              model: model,
              selected: model.orderType == selectedModel.orderType,
              onTap: () {
                onSelectTab(model, index);
              },
            );
          },
        ),
      ),
    );
  }
}
