import 'dart:convert';
import 'dart:developer';

import '../../module/address/model/country.dart';
import '../../module/address/model/state.dart';

import '../usage_criteria.dart';

class OrderShippingAddress implements UsageCriteria {
  const OrderShippingAddress({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.lat,
    this.lng,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final StateLocation state;
  final Country country;
  final double lat;
  final double lng;

  OrderShippingAddress copyWith({
    int id,
    String name,
    String email,
    String phone,
    String address,
    String city,
    StateLocation state,
    Country country,
    double lat,
    double lng,
  }) {
    try {
      return OrderShippingAddress(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
    } catch (e) {
      log('Exception in OrderShippingAddress.copyWith : $e');
      return const OrderShippingAddress();
    }
  }

  factory OrderShippingAddress.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderShippingAddress();

    try {
      return OrderShippingAddress.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in OrderShippingAddress.fromJson : $e');
      return const OrderShippingAddress();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderShippingAddress.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const OrderShippingAddress();

      return OrderShippingAddress(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        city: json['city'] as String,
        state: StateLocation.fromMap(
          (json['state'] ?? <String ,dynamic>{}) as Map<String, dynamic>,
        ),
        country: Country.fromMap(
          (json['country'] ?? <String ,dynamic>{}) as Map<String, dynamic>,
        ),
        lat: json['lat']?.toDouble() as double,
        lng: json['lng']?.toDouble() as double,
      );
    } catch (e) {
      log('Exception in OrderShippingAddress.fromMap : $e');
      return const OrderShippingAddress();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state?.toMap(),
        'country': country?.toMap(),
        'lat': lat,
        'lng': lng,
      };
    } catch (e) {
      log('Exception in OrderShippingAddress.toMap : $e');
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
