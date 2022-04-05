import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import '../../branch/model/branch_availability.dart';
import 'product_gallery.dart';
import 'variant_attribute_value.dart';

class Variant extends UsageCriteria {
  const Variant({
    this.id,
    this.productTemplateId,
    this.name,
    this.displayName,
    this.branchesAvailability,
    this.attrValues,
    this.price,
    this.currency,
    this.currencySymbol,
    this.shortDescription,
    this.description,
    this.image,
    this.gallery,
    this.isFavorite,
  });

  final int id;
  final int productTemplateId;
  final String name;
  final String displayName;
  final List<BranchAvailability> branchesAvailability;
  final List<VariantAttributeValue> attrValues;
  final double price;
  final String currency;
  final String currencySymbol;
  final String shortDescription;
  final String description;
  final String image;
  final List<ProductGallery> gallery;
  final bool isFavorite;

  Variant copyWith({
    int id,
    int productTemplateId,
    String name,
    String displayName,
    List<BranchAvailability> branchesAvailability,
    List<VariantAttributeValue> variantAttrValue,
    double price,
    String currency,
    String currencySymbol,
    String shortDescription,
    String description,
    String image,
    List<ProductGallery> gallery,
    bool isFavorite,
  }) {
    try {
      return Variant(
        id: id ?? this.id,
        productTemplateId: productTemplateId ?? this.productTemplateId,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        branchesAvailability: branchesAvailability ?? this.branchesAvailability,
        attrValues: variantAttrValue ?? attrValues,
        price: price ?? this.price,
        currency: currency ?? this.currency,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        shortDescription: shortDescription ?? this.shortDescription,
        description: description ?? this.description,
        image: image ?? this.image,
        gallery: gallery ?? this.gallery,
        isFavorite: isFavorite ?? this.isFavorite,
      );
    } catch (e) {
      log('Exception in Variant.copyWith : $e');
      return const Variant();
    }
  }

  factory Variant.fromJson(String str) {
    if (str == null || str.isEmpty) return const Variant();

    try {
      return Variant.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Variant.fromJson : $e');
      return const Variant();
    }
  }

  String toJson() => json.encode(toMap());

  factory Variant.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Variant();

      return Variant(
        id: json['id'] as int,
        productTemplateId: json['product_template_id'] as int,
        name: json['name'] as String,
        displayName: json['display_name'] as String,
        branchesAvailability: List<BranchAvailability>.from(
          ((json['branches_availability'] ?? <Map>[]) as List)
              .map<BranchAvailability>(
            (dynamic x) {
              return BranchAvailability.fromMap(x as Map<String, dynamic>);
            },
          ),
        ),
        attrValues: List<VariantAttributeValue>.from(
          ((json['attr_values'] ?? <Map>[]) as List).map<VariantAttributeValue>(
            (dynamic x) =>
                VariantAttributeValue.fromMap(x as Map<String, dynamic>),
          ),
        ),
        price: json['price'] as double,
        currency: json['currency'] as String,
        currencySymbol: json['currency_symbol'] as String,
        shortDescription: json['short_description'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
        gallery: List<ProductGallery>.from(
          ((json['gallery'] ?? <Map>[]) as List).map<ProductGallery>(
            (dynamic x) => ProductGallery.fromMap(x as Map<String, dynamic>),
          ),
        ),
        isFavorite: json['is_favorite'] as bool,
      );
    } catch (e) {
      log('Exception in Variant.fromMap : $e');
      return const Variant();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'product_template_id': productTemplateId,
        'name': name,
        'display_name': displayName,
        'branches_availability': List<dynamic>.from(
          branchesAvailability?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
        'attr_values': List<dynamic>.from(
          attrValues?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
        'price': price,
        'currency': currency,
        'currency_symbol': currencySymbol,
        'short_description': shortDescription,
        'description': description,
        'image': image,
        'gallery':
            List<dynamic>.from(gallery?.map<Map>((x) => x?.toMap()) ?? <Map>[]),
        'is_favorite': isFavorite,
      };
    } catch (e) {
      log('Exception in Variant.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name.isNotEmpty && price != null;
    } catch (e) {
      log('Exception in Variant.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Variant.unUsable : $e');
      return true;
    }
  }
}
