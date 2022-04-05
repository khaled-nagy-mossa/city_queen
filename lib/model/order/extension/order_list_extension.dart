import 'dart:developer';

import '../order_list.dart';

extension OrderListExtension on OrderList {
  List<int> getOrdersIds() {
    final arr = <int>[];
    try {
      for (final order in orders) {
        arr.add(order.id);
      }
    } catch (e) {
      log('Exception in OrderList.getOrdersIds : $e');
    }
    return arr;
  }

  bool get empty {
    try {
      return count == null || count == 0 || orders == null || orders.isEmpty;
    } catch (e) {
      log('Exception in OrderList.empty : $e');
      return true;
    }
  }

  bool get notEmpty {
    try {
      return !empty;
    } catch (e) {
      log('Exception in OrderList.notEmpty : $e');
      return true;
    }
  }
}
