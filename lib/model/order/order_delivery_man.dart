import 'dart:convert';
import 'dart:developer';
import '../usage_criteria.dart';
import 'order_current_location.dart';

class OrderDeliveryMan implements UsageCriteria {
  const OrderDeliveryMan({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.currentLocation,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final OrderCurrentLocation currentLocation;

  OrderDeliveryMan copyWith({
    int id,
    String name,
    String email,
    String phone,
    String image,
    OrderCurrentLocation currentLocation,
  }) {
    try {
      return OrderDeliveryMan(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        currentLocation: currentLocation ?? this.currentLocation,
      );
    } catch (e) {
      log('Exception in OrderDeliveryMan.copyWith : $e');
      return const OrderDeliveryMan();
    }
  }

  factory OrderDeliveryMan.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderDeliveryMan();

    try {
      return OrderDeliveryMan.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderDeliveryMan.fromJson : $e');
      return const OrderDeliveryMan();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderDeliveryMan.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const OrderDeliveryMan();

      return OrderDeliveryMan(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        image: json['image'] as String,
        currentLocation: OrderCurrentLocation.fromMap(
          (json['current_location'] ?? <String, dynamic>{})
              as Map<String, dynamic>,
        ),
      );
    } catch (e) {
      log('Exception in OrderDeliveryMan.fromMap : $e');
      return const OrderDeliveryMan();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'current_location': currentLocation?.toMap(),
      };
    } catch (e) {
      log('Exception in OrderDeliveryMan.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in OrderDeliveryMan.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in OrderDeliveryMan.usable : $e');
      return false;
    }
  }
}
