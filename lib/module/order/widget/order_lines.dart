import 'package:flutter/material.dart';
import '../../../model/order/order_line.dart';
import '../../../widget/custom_shadow.dart';

import 'line_item.dart';

class OrderLines extends StatelessWidget {
  final List<OrderLine> lines;

  const OrderLines({@required this.lines}) : assert(lines != null);

  @override
  Widget build(BuildContext context) {
    if (lines.isEmpty) return const SizedBox();

    return CustomShadow(
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: lines?.length ?? 0,
          itemBuilder: (context, index) {
            final line = lines[index];
            return LineItem(line: line);
          },
          separatorBuilder: (context, index) {
            return const Divider(endIndent: 10.0, indent: 10.0);
          },
        ),
      ),
    );
  }
}
