import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import '../../category/model/abstract_category.dart';
import 'product_attribute.dart';
import 'product_gallery.dart';
import 'product_review.dart';
import 'product_review_list.dart';
import 'variant.dart';

class Product implements UsageCriteria {
  const Product({
    this.id,
    this.name,
    this.categories,
    this.attributes,
    this.defaultVariant,
    this.price,
    this.currency,
    this.currencySymbol,
    this.shortDescription,
    this.description,
    this.image,
    this.gallery,
    this.reviews,
    this.myReview,
  });

  final int id;
  final String name;
  final List<AbstractCategory> categories;
  final List<ProductAttribute> attributes;
  final Variant defaultVariant;
  final double price;
  final String currency;
  final String currencySymbol;
  final String shortDescription;
  final String description;
  final String image;
  final List<ProductGallery> gallery;
  final ProductReviewList reviews;
  final ProductReview myReview;

  Product copyWith({
    int id,
    String name,
    List<AbstractCategory> categories,
    List<ProductAttribute> attributes,
    Variant defaultVariant,
    double price,
    String currency,
    String currencySymbol,
    String shortDescription,
    String description,
    String image,
    List<ProductGallery> gallery,
    ProductReviewList reviews,
    ProductReview myReview,
  }) {
    try {
      return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        categories: categories ?? this.categories,
        attributes: attributes ?? this.attributes,
        defaultVariant: defaultVariant ?? this.defaultVariant,
        price: price ?? this.price,
        currency: currency ?? this.currency,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        shortDescription: shortDescription ?? this.shortDescription,
        description: description ?? this.description,
        image: image ?? this.image,
        gallery: gallery ?? this.gallery,
        reviews: reviews ?? this.reviews,
        myReview: myReview ?? this.myReview,
      );
    } catch (e) {
      log('Exception in Product.copyWith : $e');
      return const Product();
    }
  }

  factory Product.fromJson(String str) {
    if (str == null || str.isEmpty) return const Product();

    try {
      return Product.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Product.fromJson : $e');
      return const Product();
    }
  }

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Product();

      return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        categories: List<AbstractCategory>.from(
          ((json['categories'] ?? <Map>[]) as List).map<AbstractCategory>(
            (dynamic x) => AbstractCategory.fromMap(x as Map<String, dynamic>),
          ),
        ),
        attributes: List<ProductAttribute>.from(
          ((json['attributes'] ?? <Map>[]) as List).map<ProductAttribute>(
            (dynamic x) => ProductAttribute.fromMap(x as Map<String, dynamic>),
          ),
        ),
        defaultVariant: Variant.fromMap(
          (json['default_variant'] ?? <String, dynamic>{})
              as Map<String, dynamic>,
        ),
        price: json['price'] as double,
        currency: json['currency'] as String,
        currencySymbol: json['currency_symbol'] as String,
        shortDescription: json['short_description'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
        gallery: List<ProductGallery>.from(
          ((json['gallery'] ?? <Map>[]) as List).map<ProductGallery>(
              (dynamic x) => ProductGallery.fromMap(x as Map<String, dynamic>)),
        ),
        reviews: ProductReviewList.fromMap(
          (json['reviews'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        myReview: ProductReview.fromMap(
          (json['my_review'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
      );
    } catch (e) {
      log('Exception in Product.fromMap in : $e');
      return const Product();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'categories': List<Map<String, dynamic>>.from(
          categories?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
        'attributes': List<dynamic>.from(
          attributes?.map<Map>((e) => e?.toMap()) ?? <Map>[],
        ),
        'default_variant': defaultVariant?.toMap(),
        'price': price,
        'currency': currency,
        'currency_symbol': currencySymbol,
        'short_description': shortDescription,
        'description': description,
        'image': image,
        'gallery': List<Map<String, dynamic>>.from(
          gallery?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
        'reviews': reviews?.toMap(),
        'my_review': myReview?.toMap(),
      };
    } catch (e) {
      log('Exception in Product.toMap : $e');
      return const <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return id != null &&
          name.isNotEmpty &&
          price != null &&
          defaultVariant != null &&
          defaultVariant.usable;
    } catch (e) {
      log('Exception in Product.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Product.unUsable : $e');
      return true;
    }
  }
}
