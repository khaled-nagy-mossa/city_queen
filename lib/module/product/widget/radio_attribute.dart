import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product_attribute.dart';
import '../model/product_attribute_value.dart';

class RadioAttributeWidget extends StatelessWidget {
  final ProductAttribute attribute;
  final ProductAttributeValue defaultVariantValue;
  final void Function(
    ProductAttributeValue newAttr,
    ProductAttributeValue oldAttr,
  ) onSelect;

  const RadioAttributeWidget({
    this.attribute,
    this.defaultVariantValue,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (attribute.unusable) {
      return const SizedBox();
    }

    try {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 7,
            ),
          ],
        ),
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    attribute.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text('Please choose that you want'.tr),
                ),
                Container(
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: (attribute.values.map((e) {
                              return GestureDetector(
                                onTap: () => onSelect(e, defaultVariantValue),
                                child: _item(
                                    context, e, defaultVariantValue.id == e.id),
                              );
                            }) ??
                            [])
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      log('Exception in RadioAttributeWidget : $e'.tr);
      return const SizedBox();
    }
  }

  Widget _item(
    BuildContext context,
    ProductAttributeValue attribute,
    bool selected,
  ) {
    try {
      return Container(
        height: 50.0,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: selected
                ? Theme.of(context).primaryColor.withOpacity(0.7)
                : Colors.grey,
            width: selected ? 1.5 : 0.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(attribute.name),
      );
    } catch (e) {
      log('Exception in RadioAttributeWidget._item : $e'.tr);
      return const SizedBox();
    }
  }
}
