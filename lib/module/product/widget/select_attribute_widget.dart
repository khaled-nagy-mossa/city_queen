import 'dart:developer';

import 'package:flutter/material.dart';
import '../model/extension/product_attribute_extension.dart';

import '../model/product_attribute.dart';
import '../model/product_attribute_value.dart';

class SelectAttributeWidget extends StatelessWidget {
  final ProductAttribute attribute;
  final ProductAttributeValue defaultVariantValue;
  final void Function(
    ProductAttributeValue newAttr,
    ProductAttributeValue oldAttr,
  ) onSelect;

  const SelectAttributeWidget({
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
                ),
                Card(
                  child: DropdownButtonFormField<int>(
                    elevation: 0,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                    value: defaultVariantValue.id,
                    onChanged: (id) => onSelect(
                      attribute.findAttributeValueById(id),
                      defaultVariantValue,
                    ),
                    items: attribute.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(e.name ?? ''),
                            ),
                          ),
                        )
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
      log('Exception in SelectAttributeWidget : $e');
      return const SizedBox();
    }
  }
}
