import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';

import '../../../common/assets/assets.dart';
import '../../../common/config/api.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../favourite/widget/favourite_button.dart';
import '../model/variant.dart';

class ProductMainData extends StatelessWidget {
  final Variant variant;

  const ProductMainData({@required this.variant}) : assert(variant != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.zero,
      title: Text(
        variant.name ?? '',
        // textAlign: TextAlign.justify,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 5.0),
        child: Text(
          '${variant.currencySymbol}${variant.price}',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: Container(
        constraints: const BoxConstraints(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FavouriteButton(variantId: variant?.id),
            const SizedBox(width: 15.0),
            GestureDetector(
              onTap: () async {
                try {
                  await Share.share(
                    '${API.domain}/shop/product/${variant.productTemplateId}',
                  );
                } catch (e) {
                  AppSnackBar.error(context, e.toString());
                }
              },
              child: SvgPicture.asset(
                Assets.images.share,
                height: 25.0,
                width: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
