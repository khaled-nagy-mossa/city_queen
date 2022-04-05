import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../model/usage_criteria.dart';
import '../common/const.dart';

class ChatUser extends UsageCriteria {
  const ChatUser({
    @required this.id,
    @required this.name,
    @required this.avatar,
  });

  final String id;
  final String name;
  final String avatar;

  ChatUser copyWith({
    String id,
    String name,
    String avatar,
  }) {
    try {
      return ChatUser(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );
    } catch (e) {
      log('Exception in ChatUser.copyWith : $e');
      return this;
    }
  }

  factory ChatUser.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) {
        return const ChatUser(id: null, name: null, avatar: null);
      }

      return ChatUser.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ChatUser.fromJson : $e');
      return const ChatUser(id: null, name: null, avatar: null);
    }
  }

  String toJson() => json.encode(toMap());

  factory ChatUser.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) {
        return const ChatUser(id: null, name: null, avatar: null);
      }

      return ChatUser(
        id: json[ConstChatData.idField] as String,
        name: json[ConstChatData.nameField] as String,
        avatar: json[ConstChatData.avatarField] as String,
      );
    } catch (e) {
      log('Exception in ChatUser.fromMap : $e');
      return const ChatUser(id: null, name: null, avatar: null);
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        ConstChatData.idField: id,
        ConstChatData.nameField: name,
        ConstChatData.avatarField: avatar,
      };
    } catch (e) {
      log('Exception in ChatUser.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ChatUser.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null && avatar != null;
    } catch (e) {
      log('Exception in ChatUser.usable : $e');
      return false;
    }
  }
}
