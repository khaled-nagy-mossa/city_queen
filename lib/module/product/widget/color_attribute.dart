import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/product_attribute.dart';
import '../model/product_attribute_value.dart';
import 'color_attribute_item.dart';

class ColorAttributeWidget extends StatelessWidget {
  final ProductAttribute attribute;
  final ProductAttributeValue defaultVariantValue;
  final void Function(
    ProductAttributeValue newAttr,
    ProductAttributeValue oldAttr,
  ) onSelect;

  const ColorAttributeWidget({
    @required this.attribute,
    @required this.defaultVariantValue,
    @required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    try {
      if (attribute.unusable) return const SizedBox();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attribute?.name ?? 'Attribute',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20.0),
          Container(
            height: 50.0,
            alignment: Alignment.centerLeft,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: _items(context),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      );
    } catch (e) {
      log('Exception in ColorAttributeWidget : $e');
      return const SizedBox();
    }
  }

  List<Widget> _items(BuildContext context) {
    try {
      final items = <Widget>[];
      for (final attrValue in attribute?.values ?? <ProductAttributeValue>[]) {
        if (attrValue.usable) {
          items.add(
            GestureDetector(
              onTap: () => onSelect(attrValue, defaultVariantValue),
              child: ColorAttributeItem(
                attribute: attrValue,
                selected: defaultVariantValue?.id == attrValue.id,
              ),
            ),
          );
        }
      }
      return items;
    } catch (e) {
      log('Exception in ColorAttributeWidget._items : $e');
      return [];
    }
  }
}
