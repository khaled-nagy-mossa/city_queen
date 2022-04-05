import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../model/order/order.dart';
import '../../../widget/custom_shadow.dart';
import '../controller/const.dart';
import '../view/order_view.dart';
import 'order_type.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final OrderType type;

  const OrderItem({@required this.order, @required this.type})
      : assert(order != null),
        assert(type != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.push(context, OrderView(order: order));
      },
      child: CustomShadow(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0.0,
          child: ListTile(
            title: Text('Order ID #${order.id}'),
            subtitle: Text(
              '${order?.currencySymbol} ${order?.total?.toString() ?? ''}',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OrderTypeWidget(order: order, type: type),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
