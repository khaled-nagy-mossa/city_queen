import 'dart:convert';
import 'dart:developer';
import '../usage_criteria.dart';

class OrderCurrentLocation implements UsageCriteria{
  const OrderCurrentLocation({this.lat, this.lng});

  final double lat;
  final double lng;

  OrderCurrentLocation copyWith({double lat, double lng}) {
    try {
      return OrderCurrentLocation(lat: lat ?? this.lat, lng: lng ?? this.lng);
    } catch (e) {
      log('Exception in OrderCurrentLocation.copyWith : $e');
      return const OrderCurrentLocation();
    }
  }

  factory OrderCurrentLocation.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderCurrentLocation();
    try {
      return OrderCurrentLocation.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in OrderCurrentLocation.fromJson : $e');
      return const OrderCurrentLocation();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderCurrentLocation.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const OrderCurrentLocation();

      return OrderCurrentLocation(
        lat: json['lat'] as double,
        lng: json['lng'] as double,
      );
    } catch (e) {
      log('Exception in OrderCurrentLocation.fromMap : $e');
      return const OrderCurrentLocation();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return<String ,dynamic> {'lat': lat, 'lng': lng};
    } catch (e) {
      log('Exception in OrderCurrentLocation.toMap : $e');
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
