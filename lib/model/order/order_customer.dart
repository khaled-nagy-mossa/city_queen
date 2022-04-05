import 'dart:convert';

import 'dart:developer';

import '../usage_criteria.dart';

class OrderCustomer implements UsageCriteria{
  const OrderCustomer({this.name, this.email, this.phone, this.image});

  final String name;
  final String email;
  final String phone;
  final String image;

  OrderCustomer copyWith({
    String name,
    String email,
    String phone,
    String image,
  }) {
    try {
      return OrderCustomer(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
      );
    } catch (e) {
      log('Exception in OrderCustomer.copyWith : $e');
      return const OrderCustomer();
    }
  }

  factory OrderCustomer.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderCustomer();

    try {
      return OrderCustomer.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderCustomer.fromJson : $e');
      return const OrderCustomer();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderCustomer.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const OrderCustomer();

      return OrderCustomer(
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        image: json['image'] as String,
      );
    } catch (e) {
      log('Exception in OrderCustomer.fromMap : $e');
      return const OrderCustomer();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
      };
    } catch (e) {
      log('Exception in OrderCustomer.toMap : $e');
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
