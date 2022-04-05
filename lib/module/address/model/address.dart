import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'country.dart';

class Address implements UsageCriteria {
  const Address({
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
  final Country state;
  final Country country;
  final double lat;
  final double lng;

  Address copyWith({
    int id,
    String name,
    String email,
    String phone,
    String address,
    String city,
    Country state,
    Country country,
    double lat,
    double lng,
  }) {
    try {
      return Address(
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
      log('Exception in Address.copyWith : $e');
      return this;
    }
  }

  factory Address.fromJson(String str) {


    try {
      if (str == null || str.isEmpty) return const Address();

      return Address.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Address.fromJson : $e');
      return const Address();
    }
  }

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Address();

      return Address(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        city: json['city'] as String,
        state: Country.fromMap(
          (json['state'] ?? <String ,dynamic>{}) as Map<String, dynamic>,
        ),
        country: Country.fromMap(
          (json['country'] ??<String ,dynamic> {}) as Map<String, dynamic>,
        ),
        lat: json['lat'].toDouble() as double,
        lng: json['lng'].toDouble() as double,
      );
    } catch (e) {
      log('Exception in Address.fromMap : $e');
      return const Address();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
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
      log('Exception in Address.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Address.toMap : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null && lat != null && lng != null;
    } catch (e) {
      log('Exception in Address.toMap : $e');
      return true;
    }
  }
}
