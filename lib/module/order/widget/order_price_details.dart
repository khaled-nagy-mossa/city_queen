import 'package:flutter/material.dart';
import '../../../model/order/order.dart';
import 'package:get/get.dart';

class OrderPriceDetails extends StatelessWidget {
  final Order order;

  const OrderPriceDetails({@required this.order}) : assert(order != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0.0,
          title: Text('Amount'.tr),
          trailing: Text('${order?.currencySymbol} ${order.amount ?? 0.0}'.tr),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0.0,
          title: Text('Taxes'.tr),
          trailing: Text('${order?.currencySymbol} ${order?.taxes ?? 0.0}'.tr),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0.0,
          title: Text(
            'Total'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            '${order?.currencySymbol} ${order.total ?? 0.0}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
