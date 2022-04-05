import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../model/usage_criteria.dart';
import '../common/const.dart';

class RoomData extends UsageCriteria {
  const RoomData({@required this.id});

  final String id;

  RoomData copyWith({String id}) {
    try {
      return RoomData(id: id ?? this.id);
    } catch (e) {
      log('Exception in RoomData.copyWith : $e');
      return this;
    }
  }

  factory RoomData.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const RoomData(id: null);

      return RoomData.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in RoomData.fromJson : $e');
      return const RoomData(id: null);
    }
  }

  String toJson() => json.encode(toMap());

  factory RoomData.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const RoomData(id: null);

      return RoomData(id: json[ConstChatData.roomIdField] as String);
    } catch (e) {
      log('Exception in RoomData.fromMap : $e');
      return const RoomData(id: null);
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        ConstChatData.roomIdField: id,
      };
    } catch (e) {
      log('Exception in RoomData.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in RoomData.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null;
    } catch (e) {
      log('Exception in RoomData.usable : $e');
      return false;
    }
  }
}
