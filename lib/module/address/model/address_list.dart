import 'dart:convert';
import 'dart:developer';
import '../../../model/usage_criteria.dart';

import 'address.dart';

class AddressList implements UsageCriteria {
  const AddressList({this.lines, this.count});

  final List<Address> lines;
  final int count;

  AddressList copyWith({List<Address> data, int count}) {
    try {
      return AddressList(
        lines: data ?? lines,
        count: count ?? this.count,
      );
    } catch (e) {
      log('Exception in AddressList.copyWith : $e');
      return this;
    }
  }

  factory AddressList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const AddressList();

      return AddressList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in AddressList.fromJson : $e');
      return const AddressList();
    }
  }

  String toJson() => json.encode(toMap());

  factory AddressList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const AddressList();

      return AddressList(
        count: ((json['data'] ?? <Map>[]) as List).length,
        lines: List<Address>.from(
          ((json['data'] ?? <Map>[]) as List).map<Address>(
            (dynamic x) => Address.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in AddressList.fromMap : $e');
      return const AddressList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'data': List<Address>.from(lines?.map<Map>((x) => x.toMap())) ?? [],
      };
    } catch (e) {
      log('Exception in AddressList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in AddressList.toMap : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return count != null && lines != null;
    } catch (e) {
      log('Exception in AddressList.toMap : $e');
      return true;
    }
  }
}
