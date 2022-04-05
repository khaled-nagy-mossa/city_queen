import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'state.dart';

class StateList implements UsageCriteria {
  const StateList({this.items});

  final List<StateLocation> items;

  StateList copyWith({List<StateLocation> data}) {
    try {
      return StateList(items: data ?? items);
    } catch (e) {
      log('Exception in StateList.copyWith : $e');
      return this;
    }
  }

  factory StateList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const StateList();

      return StateList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in StateList.fromJson : $e ');
      return const StateList();
    }
  }

  String toJson() => json.encode(toMap());

  factory StateList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const StateList();

      return StateList(
        items: List<StateLocation>.from(
          ((json['data'] ??<Map> []) as List).map<StateLocation>(
            (dynamic x) => StateLocation.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in StateList.fromMap : $e');
      return const StateList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'data': List<Map<String, dynamic>>.from(
          items?.map<Map>((x) => x?.toMap()) ?? <Map>[],
        ),
      };
    } catch (e) {
      log('Exception in StateList.toMap : $e');
      return <String, dynamic>{};
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
      return items != null;
    } catch (e) {
      log('Exception in Address.toMap : $e');
      return true;
    }
  }
}
