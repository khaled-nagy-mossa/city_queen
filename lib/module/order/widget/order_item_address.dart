import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';
import '../../../model/order/order.dart';

//ignore: must_be_immutable
class OrderItemAddress extends StatelessWidget {
  final Order order;

  OrderItemAddress({@required this.order, Key key}) : super(key: key) {
    _initData();
  }

  String from = '';
  String to = '';

  void _initData() {
    from = order.shippingAddress?.address ?? 'UnKnown';

    var temp = '';

    temp = order?.shippingAddress?.city;
    if (temp != null) to += temp;

    temp = order?.shippingAddress?.state?.name;
    if (temp != null) {
      if (to.isEmpty) {
        to = temp;
      } else {
        to += ' / $temp';
      }
    }

    temp = order?.shippingAddress?.country?.name;
    if (temp != null) {
      if (to.isEmpty) {
        to = temp;
      } else {
        to += ' / $temp';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 5.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: AppData.customGradient,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (from.isNotEmpty)
                  Text(
                    from,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                if (from.isNotEmpty && to.isNotEmpty)
                  const SizedBox(height: 15.0),
                Text(
                  to,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
