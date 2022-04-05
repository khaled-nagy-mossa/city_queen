import 'dart:developer';

import '../product_attribute.dart';

import '../product_attribute_value.dart';

extension ProductAttributeExtension on ProductAttribute {
  ProductAttributeValue findAttributeValueById(int id) {
    try {
      ProductAttributeValue attribute;
      for (final value in values) {
        if (value.id == id) {
          attribute = value;
          break;
        }
      }
      return attribute;
    } catch (e) {
      log('Exception in ProductAttributeExtension.findAttributeValueById : $e');
      return null;
    }
  }
}
