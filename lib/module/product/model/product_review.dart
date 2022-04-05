import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class ProductReview implements UsageCriteria {
  const ProductReview({
    this.rating,
    this.feedback,
    this.user,
    this.image,
  });

  final double rating;
  final String feedback;
  final String user;
  final String image;

  ProductReview copyWith({
    double rating,
    String feedback,
    String user,
    String image,
  }) {
    try {
      return ProductReview(
        rating: rating ?? this.rating,
        feedback: feedback ?? this.feedback,
        user: user ?? this.user,
        image: image ?? this.image,
      );
    } catch (e) {
      log('Exception in ProductReview.copyWith : $e');
      return const ProductReview();
    }
  }

  factory ProductReview.fromJson(String str) {
    if (str == null || str.isEmpty) return const ProductReview();

    try {
      return ProductReview.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductReview.fromJson : $e');
      return const ProductReview();
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductReview.fromMap(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return const ProductReview();

    try {
      return ProductReview(
        rating: json['rating']?.toDouble() as double,
        feedback: json['feedback'] as String,
        user: json['user'] as String,
        image: json['image'] as String,
      );
    } catch (e) {
      log('Exception in ProductReview.fromMap : $e');
      return const ProductReview();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'rating': rating,
        'feedback': feedback,
        'user': user,
        'image': image,
      };
    } catch (e) {
      log('Exception in ProductReview.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ProductReview.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return rating != null && user != null && image.isNotEmpty;
    } catch (e) {
      log('Exception in ProductReview.usable : $e');
      return false;
    }
  }
}
