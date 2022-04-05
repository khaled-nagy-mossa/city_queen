import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/assets/assets.dart';
import '../../global/view/empty_view.dart';
import '../../product/model/product.dart';
import '../../product/model/product_review_list.dart';
import '../view/product_review.dart';
import 'item.dart';
import 'package:get/get.dart';

class ReviewList extends StatelessWidget {
  final Product product;
  final ProductReviewList reviewList;

  const ReviewList({
    @required this.product,
    @required this.reviewList,
  }) : assert(product != null);

  Widget get _emptyWidget {
    return EmptyView(
      title: 'No Reviews Found!'.tr,
      svgPath: Assets.images.share,
      onRefresh: () async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reviewList?.reviews?.isEmpty != false) _emptyWidget;
    try {
      return Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 7,
            )
          ],
        ),
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  '${reviewList?.reviewsCount ?? 0} ${'Review'.tr}',
                ),
                trailing: TextButton(
                  onPressed: () {
                    AppRoutes.push(
                      context,
                      ProductReviewView(
                        initialData: reviewList,
                        product: product,
                      ),
                    );
                  },
                  child: Text('SEE ALL'.tr),
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: reviewList?.reviews?.length ?? 0,
                itemBuilder: (context, index) {
                  final review = reviewList.reviews[index];
                  return ReviewItem(review: review);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      log('Exception in ReviewList : $e');
      return _emptyWidget;
    }
  }
}
