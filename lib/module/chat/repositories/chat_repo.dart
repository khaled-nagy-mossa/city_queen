import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../common/const.dart';
import '../model/chat_user.dart';
import '../model/room_data.dart';

abstract class ChatRepo {
  const ChatRepo();

  ///check if room id is Exists or not
  static Future<bool> roomIdExists({@required String roomId}) async {
    assert(roomId != null);

    try {
      final d = await ConstChatData.chatCollectionReference.doc(roomId).get();

      return d?.data() != null;

      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in ChatRepo.roomIdAlreadyExists : $e');
      return false;
    }
  }

  static Future<String> createRoom({
    @required List<ChatUser> users,
    @required RoomData roomData,
  }) async {
    assert(users != null);
    assert(users.length >= 2);
    assert(users[0].usable);
    assert(users[1].usable);
    assert(roomData != null);
    assert(roomData.usable);

    try {
      final jsonRoom = _roomJsonData(users: users, room: roomData);

      if (jsonRoom == null) return null;

      await ConstChatData.chatCollectionReference.doc(roomData.id).set(
            jsonRoom,
          );

      return null;
    } catch (e) {
      log('Exception in ChatRepo.createRoom : $e');
      return e.toString();
    }
  }

  static Future<Map<String, dynamic>> getConversationData({
    @required String roomId,
  }) async {
    assert(roomId != null);

    try {
      final d = await ConstChatData.chatCollectionReference.doc(roomId).get();
      return d?.data();
    } catch (e) {
      log('Exception in ChatRepo.getConversationData : $e');
      return null;
    }
  }

  ///get all conversations that contain this data
  static Stream<QuerySnapshot> conversationsOfUser({@required String uid}) {
    assert(uid != null);

    try {
      return ConstChatData.chatCollectionReference
          .where(ConstChatData.usersIdsField, arrayContains: uid)
          .snapshots();

      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in ChatRepo.conversationOfUser : $e');
      return null;
    }
  }

  static Map<String, dynamic> _roomJsonData({
    @required RoomData room,
    @required List<ChatUser> users,
  }) {
    assert(room != null);
    assert(room.usable);
    assert(users != null);
    assert(users.length >= 2);

    try {
      final jsonUsers = <Map<String, dynamic>>[];
      final usersIds = <String>[];
      for (final user in users) {
        jsonUsers.add(user.toMap());
        usersIds.add(user.id);
      }

      return <String, dynamic>{
        ConstChatData.roomIdField: room.id,
        ConstChatData.usersField: jsonUsers,
        ConstChatData.usersIdsField: usersIds,
      };
    } catch (e) {
      log('Exception in ChatRepo._roomJsonData : $e');
      return null;
    }
  }
}
