import 'package:app_routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softgrow/module/review/widget/item.dart';

import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/cubit_extension.dart';
import '../../product/model/product.dart';
import '../../product/model/product_review.dart';
import '../view/rate_view.dart';
import 'add_review_button.dart';
import 'package:get/get.dart';

class UserComment extends StatelessWidget {
  final Product product;
  final void Function(ProductReview review) onAddReview;

  const UserComment({
    @required this.product,
    @required this.onAddReview,
  }) : assert(onAddReview != null);

  @override
  Widget build(BuildContext context) {
    if (product == null) return const SizedBox();

    if (AuthCubit?.get(context)?.signed != true) return const SizedBox();

    if (product?.myReview?.unusable != true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Your Review'.tr,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ReviewItem(review: product.myReview),
        ],
      );
    } else {
      return AddReviewButton(
        onPressed: () async {
          final review = await AppRoutes.push<ProductReview>(
              context, AddReviewView(product: product));

          if (review != null) {
            onAddReview(review.copyWith(
              user: AuthCubit?.get(context)?.user?.data?.name,
              image: AuthCubit?.get(context)?.user?.data?.avatar,
            ));
          }
        },
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      );
    }
  }
}
