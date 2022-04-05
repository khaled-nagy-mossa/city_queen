import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class Branch implements UsageCriteria {
  const Branch({
    this.id,
    this.name,
    this.email,
    this.description,
    this.phone,
    this.address,
    this.lat,
    this.lng,
    this.image,
    this.banner,
    this.topBranch,
    this.distance,
  });

  final int id;
  final String name;
  final String email;
  final String description;
  final String phone;
  final String address;
  final String lat;
  final String lng;
  final String image;
  final List<String> banner;
  final bool topBranch;
  final double distance;

  Branch copyWith({
    int id,
    String name,
    String email,
    String description,
    String phone,
    String address,
    String lat,
    String lng,
    String image,
    List<String> banner,
    bool topBranch,
    double distance,
  }) {
    try {
      return Branch(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        description: description ?? this.description,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        image: image ?? this.image,
        banner: banner ?? this.banner,
        topBranch: topBranch ?? this.topBranch,
        distance: distance ?? this.distance,
      );
    } catch (e) {
      log('Exception in Branch.copyWith : $e');
      return this;
    }
  }

  factory Branch.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const Branch();

      return Branch.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Branch.fromJson : $e');
      return const Branch();
    }
  }

  String toJson() => json.encode(toMap());

  factory Branch.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Branch();

      return Branch(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        description: json['description'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        lat: json['lat'] as String,
        lng: json['lng'] as String,
        image: json['image'] as String,
        banner: List<String>.from(
          ((json['banner'] ?? <Map>[]) as List)
              .map<String>((dynamic x) => x as String),
        ),
        topBranch: json['top_branch'] as bool,
        distance: json['distance']?.toDouble() as double,
      );
    } catch (e) {
      int id;
      if (json != null) {
        id = json['id'] as int;
      }
      log('Exception in Branch.fromMap id $id : $e');
      return const Branch();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'description': description,
        'phone': phone,
        'address': address,
        'lat': lat,
        'lng': lng,
        'image': image,
        'banner':
            List<dynamic>.from(banner?.map<String>((x) => x)) ?? <String>[],
        'top_branch': topBranch,
        'distance': distance,
      };
    } catch (e) {
      log('Exception in Branch.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in Branch.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Branch.unUsable : $e');
      return true;
    }
  }
}
