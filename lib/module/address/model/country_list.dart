import 'dart:convert';
import 'dart:developer';
import '../../../model/usage_criteria.dart';
import 'country.dart';

class CountryList implements UsageCriteria {
  const CountryList({this.items});

  final List<Country> items;

  CountryList copyWith({List<Country> data}) {
    try {
      return CountryList(items: data ?? items);
    } catch (e) {
      log('Exception in CountryList.copyWith : $e');
      return this;
    }
  }

  factory CountryList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const CountryList();

      return CountryList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in CountryList.fromJson : $e');
      return const CountryList();
    }
  }

  String toJson() => json.encode(toMap());

  factory CountryList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const CountryList();

      return CountryList(
        items: List<Country>.from(
          ((json['data'] ?? <Map>[]) as List).map<Country>(
            (dynamic x) => Country.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in CountryList.fromMap : $e');
      return const CountryList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'data':
            List<Country>.from(items?.map<Map>((x) => x.toMap()) ?? <Map>[]),
      };
    } catch (e) {
      log('Exception in CountryList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in CountryList.toMap : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return items != null;
    } catch (e) {
      log('Exception in CountryList.toMap : $e');
      return true;
    }
  }
}
