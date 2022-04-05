import 'dart:developer';

import '../order_shipping_address.dart';

extension OrderShippingAddressExtension on OrderShippingAddress {
  bool get hasLatLng {
    try {
      if (lat != null && lng != null) return true;
      return false;
    } catch (e) {
      log('Exception in OrderShippingAddress.hasLatLng : $e');
      return false;
    }
  }
}
