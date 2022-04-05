import 'dart:developer';

import '../order.dart';
import '../order_line.dart';

extension OrderExtension on Order {
  ///to get the Line in this cart by variant id [if not found return null]
  OrderLine lineByVariantId(int id) {
    try {
      if (linesLength == 0) return null;

      OrderLine orderLine;

      for (final line in lines) {
        if (line.variantId == id) {
          orderLine = line;
          break;
        }
      }

      return orderLine;
    } catch (e) {
      log('Exception in OrderExtension.lineByVariantId : $e');
      return null;
    }
  }

  int get iItemsLength {
    try {
      if (linesLength == 0) return 0;
      var length = 0;

      for (final line in lines) {
        length += line.qty;
      }

      return length;
    } catch (e) {
      log('Exception in Order.orderItemsCount : $e');
      return 0;
    }
  }

  int get linesLength {
    try {
      if (!hasLines) return 0;
      return lines?.length ?? 0;
    } catch (e) {
      log('Exception in Order.linesLength :$e');
      return 0;
    }
  }

  bool get hasLines {
    try {
      return lines != null && lines.isNotEmpty;
    } catch (e) {
      log('Exception in Order.hasLines :$e');
      return false;
    }
  }

  bool get branchHasBeenDetermined {
    return branch != null && branch.id != null && branch.name != null;
  }

  bool get isEmpty {
    if (branch == null || amount == null || total == null) return true;
    return !hasLines;
  }

  bool haveSameCartBranch(int branchId) {
    if (branchHasBeenDetermined) return true;
    return branch.id == branchId;
  }
}
