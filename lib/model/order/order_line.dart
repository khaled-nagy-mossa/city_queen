import 'dart:convert';
import 'dart:developer';
import '../usage_criteria.dart';

class OrderLine implements UsageCriteria {
  const OrderLine({
    this.id,
    this.name,
    this.variantId,
    this.productTemplateId,
    this.image,
    this.qty,
    this.priceUnit,
    this.taxId,
    this.subtotal,
  });

  final int id;
  final String name;
  final int variantId;
  final int productTemplateId;
  final String image;
  final int qty;
  final double priceUnit;
  final String taxId;
  final double subtotal;

  OrderLine copyWith({
    int id,
    String name,
    int variantId,
    int productTemplateId,
    String image,
    int qty,
    double priceUnit,
    String taxId,
    double subtotal,
  }) {
    try {
      return OrderLine(
        id: id ?? this.id,
        name: name ?? this.name,
        variantId: variantId ?? this.variantId,
        productTemplateId: productTemplateId ?? this.productTemplateId,
        image: image ?? this.image,
        qty: qty ?? this.qty,
        priceUnit: priceUnit ?? this.priceUnit,
        taxId: taxId ?? this.taxId,
        subtotal: subtotal ?? this.subtotal,
      );
    } catch (e) {
      log('Exception in OrderLine.copyWith : $e');
      return const OrderLine();
    }
  }

  factory OrderLine.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderLine();
    try {
      return OrderLine.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderLine.fromJson : $e');
      return const OrderLine();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderLine.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const OrderLine();

      return OrderLine(
        id: json['id'] as int,
        name: json['name'] as String,
        variantId: json['variant_id'] as int,
        productTemplateId: json['product_template_id'] as int,
        image: json['image'] as String,
        qty: json['qty'].toInt() as int,
        priceUnit: json['price_unit']?.toDouble() as double,
        taxId: json['tax_id'] as String,
        subtotal: json['subtotal']?.toDouble() as double,
      );
    } catch (e) {
      log('Exception in OrderLine.fromMap : $e');
      return const OrderLine();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'id': id,
        'name': name,
        'variant_id': variantId,
        'product_template_id': productTemplateId,
        'image': image,
        'qty': qty,
        'price_unit': priceUnit,
        'tax_id': taxId,
        'subtotal': subtotal,
      };
    } catch (e) {
      log('Exception in OrderLine.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  // TODO: implement unUsable
  bool get unusable => throw UnimplementedError();

  @override
  // TODO: implement usable
  bool get usable => throw UnimplementedError();
}
