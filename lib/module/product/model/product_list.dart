import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'product.dart';

class ProductList implements UsageCriteria {
  const ProductList({this.count, this.products});

  final int count;
  final List<Product> products;

  ProductList copyWith({
    int count,
    List<Product> products,
  }) {
    try {
      return ProductList(
        count: count ?? this.count,
        products: products ?? this.products,
      );
    } catch (e) {
      log('Exception in ProductList.copyWith : $e');
      return const ProductList();
    }
  }

  factory ProductList.fromJson(String str) {
    if (str == null || str.isEmpty) return const ProductList();

    try {
      return ProductList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductList.fromJson : $e');
      return const ProductList();
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductList.fromMap(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return const ProductList();

    try {
      return ProductList(
        count: json['count'] as int,
        products: List<Product>.from(
            ((json['products'] ?? <Map>[]) as List).map<Product>(
          (dynamic x) => Product.fromMap(x as Map<String, dynamic>),
        )),
      );
    } catch (e) {
      log('Exception in ProductList.fromMap : $e');
      return const ProductList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'count': count,
        'products': List<dynamic>.from(
            products?.map<Map>((x) => x?.toMap()) ?? <Map>[]),
      };
    } catch (e) {
      log('Exception in ProductList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ProductList.usable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return count != null &&
          count != 0 &&
          products != null &&
          products.isNotEmpty;
    } catch (e) {
      log('Exception in ProductList.usable : $e');
      return false;
    }
  }
}
