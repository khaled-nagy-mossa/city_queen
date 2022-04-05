import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../model/chat_user.dart';
import '../model/conversation.dart';
import '../model/room_data.dart';
import 'chat_repo.dart';
import 'message_repo.dart';

abstract class ChatService {
  const ChatService();

  ///get room id by users ids
  static String makeRoomId({
    @required String user1Id,
    @required String user2Id,
  }) {
    assert(user1Id != null);
    assert(user2Id != null);

    try {
      final users = <String>[user1Id, user2Id];
      users.sort();

      return '${users[0]}_${users[1]}';

      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in ChatService.getRoomId : $e');
      return '${user1Id}_$user2Id';
    }
  }

  static Future conversation({@required RoomData room}) async {
    assert(room != null);

    try {
      final data = await ChatRepo.getConversationData(roomId: room.id);

      if (data == null || data.isEmpty) throw 'Unknown Exception';

      return Conversation.fromMap(data);
    } catch (e) {
      log('Exception in ChatService.conversation : $e');
      return e.toString();
    }
  }

  static Future<RoomData> startRoomWith({
    @required ChatUser me,
    @required ChatUser user,
  }) async {
    assert(user != null);
    assert(user.usable);

    try {
      ///get room id between two users
      final roomId = makeRoomId(user1Id: me.id, user2Id: user.id);

      /// check if room id is found or not [To make sure that they have a previous conversation or not]
      final exists = await ChatRepo.roomIdExists(roomId: roomId);

      if (exists == true) {
        ///update this if you want
        /// it just set a data in firebase when create or update
        final errorMsg = await ChatRepo.createRoom(
          users: [me, user],
          roomData: RoomData(id: roomId),
        );
        if (errorMsg != null && errorMsg.isNotEmpty) throw errorMsg;
      } else {
        final errorMsg = await ChatRepo.createRoom(
          users: [me, user],
          roomData: RoomData(id: roomId),
        );
        if (errorMsg != null && errorMsg.isNotEmpty) throw errorMsg;
      }

      return RoomData(id: roomId);
    } catch (e) {
      log('Exception in ChatService.startRoomWith : $e');
      return null;
    }
  }

  static ChatUser getAnotherUser({
    @required List<ChatUser> users,
    @required ChatUser user,
  }) {
    assert(users != null);
    assert(users.isNotEmpty);

    assert(user != null);
    assert(user.usable);

    try {
      return users[0].id == user.id ? users[1] : users[0];
    } catch (e) {
      log('Exception in ChatService.getAnotherUser : $e');
      return users.first;
    }
  }

  static Future<String> sendMessage({
    @required ChatUser user,
    @required RoomData roomData,
    @required String msg,
  }) async {
    assert(roomData != null);
    assert(roomData.usable);

    assert(user != null);
    assert(user.usable);

    assert(msg != null);
    assert(msg.isNotEmpty);

    try {
      final result = await MessageRepo.sendMessage(
        user: user,
        roomData: roomData,
        msg: msg,
      );
      if (result != null && result.isNotEmpty) throw result;

      final result2 = await MessageRepo.updateFinalMessage(
        user: user,
        roomData: roomData,
        msg: msg,
      );
      if (result2 != null && result2.isNotEmpty) throw result2;

      final result3 = await MessageRepo.incrementConversationMessagesCount(
        roomData: roomData,
      );
      if (result3 != null && result3.isNotEmpty) throw result2;

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static String convertTimeStampToyHms(Timestamp timeStamp) {
    try {
      if (timeStamp == null) return '';

      final time = timeStamp.toDate();
      final format = DateFormat.Hm('en');
      final dateString = format.format(time);

      return dateString.toString();
    } catch (e) {
      return '';
    }
  }

  static String convertTimeStampToyMd(Timestamp timeStamp) {
    try {
      if (timeStamp == null) return '';

      final time = timeStamp.toDate();
      final format = DateFormat.yMd('en');
      final dateString = format.format(time);
      return dateString.toString();
    } catch (e) {
      return '';
    }
  }
}
