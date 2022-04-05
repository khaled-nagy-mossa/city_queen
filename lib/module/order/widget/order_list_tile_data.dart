import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';
import '../../../model/order/order.dart';
import '../controller/const.dart';

class OrderListTileData extends StatelessWidget {
  final Order order;
  final OrderType orderType;

  const OrderListTileData({
    @required this.order,
    @required this.orderType,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (order == null || order.unusable) return const SizedBox();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: _orderId(),
      subtitle: _orderName(context),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _orderStatus(context),
          const SizedBox(height: 5.0),
          _orderPrice(context),
        ],
      ),
    );
  }

  Widget _orderId() {
    return Text(
      'Order ID #${order?.id}',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _orderName(BuildContext context) {
    return Text(
      order.branch?.name ?? '',
      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }

  Widget _orderPrice(BuildContext context) {
    return Text(
      '${order?.currency} ${order?.total}',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _orderStatus(BuildContext context) {
    final status = order?.status ?? '';
    return Text(
      OrderStagesHelper.orderTypeBy(orderTypeParameter: status).title ?? status,
      style: const TextStyle(
        fontSize: 14.0,
        color: AppData.mainColor,
      ),
    );
  }
}
