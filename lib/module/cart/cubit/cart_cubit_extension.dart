import 'dart:developer';

import '../../../model/order/extension/order_extension.dart';
import '../../../model/order/order_branch.dart';
import '../../../model/order/order_customer.dart';
import '../../../model/order/order_line.dart';
import '../../../model/order/order_shipping_address.dart';
import '../../product/model/variant.dart';
import 'cart_cubit.dart';

extension CartCubitExtension on CartCubit {
  bool haveLine(int lineId) {
    if (lineId == null) return false;

    try {
      for (final line in lines) {
        if (line?.id == lineId) return true;
      }
      return false;
    } catch (e) {
      log('Exception in CartCubit.haveLine : $e');
      return false;
    }
  }

  bool get isEmpty {
    if (order == null || order.isEmpty) return true;
    return order?.hasLines == false;
  }

  int variantQuantity(int id) {
    try {
      if (order.linesLength == 0) {
        return 0;
      }

      final line = order.lineByVariantId(id);

      if (line == null) {
        return 0;
      } else {
        return line?.qty?.toInt() ?? 0;
      }
    } catch (e) {
      log('Exception in CartCubit.variantQuantity : $e');
      return 0;
    }
  }

  double totalAmount(Variant variant) {
    if (variant == null || variant.id == null) return 0.0;
    try {
      return (variant?.price ?? 0.0) * variantQuantity(variant?.id);
    } catch (e) {
      log('Exception in CartCubit.totalAmount : $e');
      return 0.0;
    }
  }

  int get id => order?.id;

  String get reference => order?.reference;

  double get amount => order?.amount;

  double get taxes => order?.taxes;

  double get total => order?.total;

  String get currency => order?.currency;

  String get currencySymbol => order?.currencySymbol;

  String get status => order?.status;

  String get paymentLink => order?.paymentLink;

  String get paymentState => order?.paymentState;

  List<OrderLine> get lines => order?.lines;

  OrderBranch get branch => order?.branch;

  int get branchId => order?.branch?.id;

  OrderCustomer get cartCustomer => order?.customer;

  OrderShippingAddress get shippingAddress => order?.shippingAddress;
}
