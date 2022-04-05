import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import '../../product/model/product.dart';
import 'home_view.dart';

class ProductsCollection extends HomeViewModel implements UsageCriteria {
  const ProductsCollection({
    this.name,
    this.products,
  });

  final String name;
  final List<Product> products;

  ProductsCollection copyWith({
    String name,
    List<Product> products,
  }) {
    try {
      return ProductsCollection(
        name: name ?? this.name,
        products: products ?? this.products,
      );
    } catch (e) {
      log('Exception in ProductsCollection.copyWith : $e');
      return this;
    }
  }

  factory ProductsCollection.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const ProductsCollection();

      return ProductsCollection.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in ProductsCollection.fromJson : $e');
      return const ProductsCollection();
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductsCollection.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const ProductsCollection();

      return ProductsCollection(
        name: json['name'] as String,
        products: List<Product>.from(
          ((json['products'] ?? <Map>[]) as List).map<Product>(
              (dynamic x) => Product.fromMap(x as Map<String, dynamic>)),
        ),
      );
    } catch (e) {
      log('Exception in ProductsCollection.fromMap : $e');
      return const ProductsCollection();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'name': name,
        'products': products?.map((x) => x?.toMap()),
      };
    } catch (e) {
      log('Exception in ProductCollection.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return name != null && products != null;
    } catch (e) {
      log('Exception in SliderBanner.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in SliderBanner.unUsable : $e');
      return true;
    }
  }
}
