import 'dart:developer';

import '../product_attribute_value.dart';

extension ProductAttributeValueExtension on ProductAttributeValue {
  bool get usableHtmlColor {
    try {
      return htmlColor != null && htmlColor.length >= 7;
    } catch (e) {
      log('Exception in ProductAttributeValueExtension.usableHtmlColor : $e');
      return false;
    }
  }
}
