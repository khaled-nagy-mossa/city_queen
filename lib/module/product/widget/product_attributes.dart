import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/extension/variant_extension.dart';
import '../model/product.dart';
import '../model/product_attribute.dart';
import '../model/product_attribute_value.dart';
import '../model/variant.dart';
import 'color_attribute.dart';
import 'radio_attribute.dart';
import 'select_attribute_widget.dart';

class ProductAttributesWidget extends StatelessWidget {
  final Product product;
  final Variant currentVariant;
  final void Function(List<int> attributesIds) onChangeAttributeValue;

  const ProductAttributesWidget({
    @required this.product,
    @required this.currentVariant,
    @required this.onChangeAttributeValue,
  })  : assert(product != null),
        assert(currentVariant != null),
        assert(onChangeAttributeValue != null);

  void _onSelect(ProductAttributeValue newAttr, ProductAttributeValue oldAttr) {
    //initial oldAttributesIds
    final returnedAttributesId = <int>[];
    returnedAttributesId.addAll(currentVariant.getAttrIds());

    //get old attribute value id
    final attributeIndex = returnedAttributesId.indexOf(oldAttr.id);

    //replace old attribute value id by new
    returnedAttributesId[attributeIndex] = newAttr.id;

    //return new list of attributes id
    onChangeAttributeValue(returnedAttributesId);
  }

  bool get _canNotUse {
    return product == null ||
        product.attributes == null ||
        product.attributes.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (_canNotUse) return Container();

    try {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: product?.attributes?.length ?? 0,
        itemBuilder: (context, index) {
          return _attribute(context, product.attributes[index]);
        },
        separatorBuilder: (context, index) => const Divider(),
      );
    } catch (e) {
      log('Exception in ProductAttributesWidget : $e');
      return const SizedBox();
    }
  }

  Widget _attribute(BuildContext context, ProductAttribute attribute) {
    ProductAttributeValue defaultVariantValue;

    for (final pAV in attribute.values) {
      if (currentVariant.getAttrIds().contains(pAV.id)) {
        defaultVariantValue = pAV;
        break;
      }
    }

    if (attribute.type == 'color') {
      return ColorAttributeWidget(
        onSelect: _onSelect,
        attribute: attribute,
        defaultVariantValue: defaultVariantValue,
      );
    } else if (attribute.type == 'radio') {
      return RadioAttributeWidget(
        onSelect: _onSelect,
        attribute: attribute,
        defaultVariantValue: defaultVariantValue,
      );
    } else {
      return SelectAttributeWidget(
        onSelect: _onSelect,
        attribute: attribute,
        defaultVariantValue: defaultVariantValue,
      );
    }
  }
}
