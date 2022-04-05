import 'dart:convert';
import 'dart:developer';
import '../../../model/usage_criteria.dart';

import 'product_review.dart';

class ProductReviewList implements UsageCriteria {
  const ProductReviewList({
    this.reviews,
    this.reviewsCount,
    this.ratingAvg,
  });

  final List<ProductReview> reviews;
  final int reviewsCount;
  final double ratingAvg;

  ProductReviewList copyWith({
    List<ProductReview> reviews,
    int reviewsCount,
    double ratingAvg,
  }) {
    try {
      return ProductReviewList(
        reviews: reviews ?? this.reviews,
        reviewsCount: reviewsCount ?? this.reviewsCount,
        ratingAvg: ratingAvg ?? this.ratingAvg,
      );
    } catch (e) {
      log('Exception in ProductReviewList.copyWith : $e');
      return const ProductReviewList();
    }
  }

  factory ProductReviewList.fromJson(String str) {
    if (str == null || str.isEmpty) return const ProductReviewList();
    try {
      return ProductReviewList.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductReviewList.fromJson : $e');
      return const ProductReviewList();
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductReviewList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const ProductReviewList();

      return ProductReviewList(
        reviews: List<ProductReview>.from(
            ((json['reviews'] ?? <Map>[]) as List).map<ProductReview>(
          (dynamic x) => ProductReview.fromMap(x as Map<String, dynamic>),
        )),
        reviewsCount: json['reviews_count'] as int,
        ratingAvg: json['rating_avg']?.toDouble() as double,
      );
    } catch (e) {
      log('Exception in ProductReviewList.fromMap : $e');
      return const ProductReviewList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'reviews': List<dynamic>.from(
          reviews?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
        'reviews_count': reviewsCount,
        'rating_avg': ratingAvg,
      };
    } catch (e) {
      log('Exception in ProductReviewList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ProductReviewList.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return reviewsCount != null && reviews != null && ratingAvg != null;
    } catch (e) {
      log('Exception in ProductReviewList.usable : $e');
      return false;
    }
  }
}
