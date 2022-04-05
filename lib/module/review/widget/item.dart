import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../../product/model/product_review.dart';
import '../../product/widget/product_rate.dart';

class ReviewItem extends StatelessWidget {
  final ProductReview review;

  const ReviewItem({@required this.review}) : assert(review != null);

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        constraints: const BoxConstraints(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                height: 55.0,
                width: 55.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(API.imageUrl(review.image)),
                  ),
                ),
              ),
              title: Text(review?.user ?? ''),
              subtitle: Text(review?.feedback ?? ''),
              trailing: Container(
                constraints: const BoxConstraints(maxHeight: 30.0),
                child: ProductRate(ratingAvg: review?.rating ?? 0.0),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      log('Exception in ReviewItem : $e');
      return const SizedBox();
    }
  }
}
