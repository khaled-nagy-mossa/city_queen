import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';
import '../model/order_type_tab_model.dart';

class OrderTap extends StatelessWidget {
  final OrderTypeTapModel model;
  final VoidCallback onTap;
  final bool selected;

  const OrderTap({
    @required this.model,
    this.onTap,
    this.selected,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: selected ? 2.0 : 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 100.0, maxHeight: 50.0),
          decoration: BoxDecoration(
            gradient: selected ? AppData.gradient : null,
          ),
          child: Text(
            model.title,
            style: TextStyle(
              color: selected ? Colors.white : AppData.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
