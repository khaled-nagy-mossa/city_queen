import 'package:flutter/material.dart';

import '../model/variant.dart';

class VariantDescription extends StatelessWidget {
  final Variant variant;

  const VariantDescription({@required this.variant}) : assert(variant != null);

  @override
  Widget build(BuildContext context) {
    if (variant.description == null || variant.description.isEmpty) {
      return const SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Text(
            'Description',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20.0),
          // HtmlWidget(variant.description
          //         .replaceAll('src='/web/', 'src='https://upsale.app/web/')
              // .replaceAll(
              //     '<div class=\'media_iframe_video\' data-oe-expression=\'//',
              //     '<iframe class=\'media_iframe_video\' src=\'https://'),
              // use replace all to add base url to image because odoo not return i
              // ),
        ],
      );
    }
  }
}
