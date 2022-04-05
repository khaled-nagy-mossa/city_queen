import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/usage_criteria.dart';
import '../common/const.dart';

class Message extends UsageCriteria {
  const Message({
    @required this.timestamp,
    @required this.userId,
    @required this.text,
  });

  final Timestamp timestamp;
  final String userId;
  final String text;

  Message copyWith({
    Timestamp timestamp,
    String userId,
    String text,
  }) {
    try {
      return Message(
        timestamp: timestamp ?? this.timestamp,
        userId: userId ?? this.userId,
        text: text ?? this.text,
      );
    } catch (e) {
      log('Exception in Message.copyWith : $e');
      return this;
    }
  }

  factory Message.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) {
        return const Message(timestamp: null, userId: null, text: null);
      }

      return Message.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Message.fromJson : $e');
      return const Message(timestamp: null, userId: null, text: null);
    }
  }

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) {
        return const Message(timestamp: null, userId: null, text: null);
      }

      return Message(
        timestamp: json[ConstChatData.dateField] as Timestamp,
        userId: json[ConstChatData.userIdField] as String,
        text: json[ConstChatData.messageField] as String,
      );
    } catch (e) {
      log('Exception in Message.fromMap : $e');
      return const Message(timestamp: null, userId: null, text: null);
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        ConstChatData.userIdField: userId,
        ConstChatData.messageField: text,
        ConstChatData.dateField: timestamp?.toString(),
      };
    } catch (e) {
      log('Exception in Message.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Message.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return userId != null && text != null && timestamp != null;
    } catch (e) {
      log('Exception in Message.unUsable : $e');
      return false;
    }
  }
}
