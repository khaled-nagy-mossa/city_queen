import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../../product/model/variant.dart';
import '../../product/view/product.dart';
import 'favourite_button.dart';

class FavouriteItem extends StatelessWidget {
  final Variant variant;
  final VoidCallback onDelete;

  const FavouriteItem({@required this.variant, @required this.onDelete})
      : assert(onDelete != null);

  @override
  Widget build(BuildContext context) {
    if (variant == null) return const SizedBox();

    try {
      return ListTile(
        onTap: () {
          if (variant?.id == null) {
            return;
          }
          AppRoutes.push(
              context, ProductView(productId: variant.productTemplateId));
        },
        leading: _variantImage(context),
        title: _variantName(context),
        subtitle: _price(context),
        trailing: _removeButton(context),
      );
    } catch (e) {
      log('Exception in FavouriteItem : $e');
      return const SizedBox();
    }
  }

  Widget _variantImage(BuildContext context) {
    try {
      return Container(
        height: 55.0,
        width: 55.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xFFF7F7F9),
          image: DecorationImage(
            image: NetworkImage(API.imageUrl(variant.image)),
          ),
        ),
      );
    } catch (e) {
      log('Exception in FavouriteItem._variantImage : $e');
      return const SizedBox();
    }
  }

  Widget _variantName(BuildContext context) {
    try {
      return Text(
        variant?.name ?? '',
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      );
    } catch (e) {
      log('Exception in FavouriteItem._variantName : $e');
      return const SizedBox();
    }
  }

  Widget _price(BuildContext context) {
    try {
      return Text(
        '${variant?.currencySymbol}${variant?.price}' ?? '',
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } catch (e) {
      log('Exception in FavouriteItem._price : $e');
      return const SizedBox();
    }
  }

  Widget _removeButton(BuildContext context) {
    try {
      return FavouriteButton(variantId: variant.id);
      // return IconButton(
      //   icon: const Icon(Icons.delete),
      //   onPressed: onDelete,
      // );
    } catch (e) {
      log('Exception in FavouriteItem._removeButton : $e');
      return const SizedBox();
    }
  }
}
