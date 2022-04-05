import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../../../model/order/order_line.dart';
import '../../../widget/simple_counter.dart';
import '../../product/view/product.dart';

class CartItem extends StatelessWidget {
  final int counter;
  final OrderLine line;
  final VoidCallback onDelete;
  final Future<bool> Function(int index) onQuantityChanged;
  final bool useCounter;

  const CartItem({
    @required this.counter,
    @required this.line,
    @required this.onDelete,
    @required this.onQuantityChanged,
    this.useCounter = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        AppRoutes.push(context, ProductView(productId: line.productTemplateId));
      },
      leading: Container(
        height: 55.0,
        width: 55.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(API.imageUrl(line.image)),
          ),
        ),
      ),
      title: Wrap(
        children: [
          Text(
            line.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (useCounter)
            SimpleCounter(
              counter: counter,
              counterColor: Colors.black,
              onChanged: onQuantityChanged,
            )
          else
            Text('${line.qty} X ${line.priceUnit}'),
          Text('${line.subtotal}'),
        ],
      ),
    );
  }
}
