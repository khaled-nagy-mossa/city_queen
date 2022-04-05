import 'dart:developer';

import 'package:flutter/material.dart';

import '../../product/model/product_review_list.dart';
import '../model/reviews_params.dart';
import 'repo.dart';

abstract class ReviewService {
  const ReviewService();

  static Future reviews({
    @required ReviewsParams params,
  }) async {
    assert(params != null);

    try {
      final res = await ReviewRepo.reviews(params);

      if (res.hasError) throw res.msg;

      return ProductReviewList.fromMap(
        res.json['result'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ReviewService.reviews : $e');
      return e.toString();
    }
  }

  //addReview Initialize the base.
  static Future<String> addReview({@required Map<String, dynamic> data}) async {
    assert(data != null);

    try {
      final res = await ReviewRepo.addReview(data: data);

      if (res.hasError) throw res.msg;

      return null;
    } catch (e) {
      log('Exception in addReview in ReviewService : $e');
      return e.toString();
    }
  }
}
