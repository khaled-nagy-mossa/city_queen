import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../model/extension/product_attribute_value_extension.dart';
import '../model/product_attribute_value.dart';

class ColorAttributeItem extends StatelessWidget {
  final ProductAttributeValue attribute;
  final bool selected;

  const ColorAttributeItem({
    @required this.attribute,
    @required this.selected,
  })  : assert(attribute != null),
        assert(selected != null);

  @override
  Widget build(BuildContext context) {
    try {
      if (attribute.unusable) return const SizedBox();

      return Card(
        margin: const EdgeInsets.only(right: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          clipBehavior: Clip.hardEdge,
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 40.0,
              maxWidth: 50.0,
            ),
            child: Stack(
              children: [
                _backgroundItem(context),
                if (selected)
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      Assets.images.check,
                      color: Colors.white,
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      log('Exception in ColorAttributeItem : $e');
      return const SizedBox();
    }
  }

  Widget _backgroundItem(BuildContext context) {
    try {
      if (attribute.usableHtmlColor) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(
              int.parse(attribute.htmlColor.substring(1, 7), radix: 16) +
                  0xFF000000,
            ),
          ),
        );
      } else {
        return Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(
              attribute.name ?? '',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      log('Exception in ColorAttributeItem._backgroundItem : $e');
      return const SizedBox();
    }
  }
}
