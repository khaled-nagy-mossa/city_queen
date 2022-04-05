import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product/product_cubit.dart';
import '../cubit/variant/variant_cubit.dart';
import '../cubit/variant/variant_states.dart';
import '../model/variant.dart';
import '../widget/branches_collection.dart';
import '../widget/categories_collection.dart';
import '../widget/product_attributes.dart';
import '../widget/product_html_description.dart';
import '../widget/variant_short_description.dart';

class ProductDescriptionView extends StatelessWidget {
  final Variant currentVariant;

  const ProductDescriptionView({@required this.currentVariant});

  RoundedRectangleBorder get _border {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
  }

  SizedBox get _sizedBox => const SizedBox(height: 20.0, width: 20.0);

  BoxShadow get _boxShadow {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 0.1,
      blurRadius: 7,
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return BlocConsumer<VariantCubit, VariantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final vc = VariantCubit.get(context);
          final pc = ProductViewCubit.get(context);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20.0),
              if (vc?.variant?.shortDescription?.isNotEmpty == true)
                VariantShortDescription(
                  variant: vc?.variant,
                  boxShadow: _boxShadow,
                  border: _border,
                ),
              if (currentVariant?.branchesAvailability?.isNotEmpty == true)
                Container(
                  margin: EdgeInsets.only(top: _sizedBox.height),
                  child: BranchesCollection(
                    border: _border,
                    boxShadow: _boxShadow,
                    branches: currentVariant.branchesAvailability ?? [],
                  ),
                ),
              if (pc?.product?.categories?.isNotEmpty == true)
                Container(
                  margin: EdgeInsets.only(top: _sizedBox.height),
                  child: CategoriesCollection(
                    border: _border,
                    boxShadow: _boxShadow,
                    categories: pc.product.categories,
                  ),
                ),
              _sizedBox,
              ProductAttributesWidget(
                product: pc.product,
                currentVariant: vc.variant,
                onChangeAttributeValue: (ids) {
                  vc.loadVariant(productId: pc.product.id, attrId: ids);
                },
              ),
              _sizedBox,
              ProductHtmlDescription(html: vc?.variant?.description),
            ],
          );
        },
      );
    } catch (e) {
      log('Exception in ProductDescriptionView : $e');
      return Center(
        child: Text(e.toString()),
      );
    }
  }
}
