import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../common/const.dart';
import '../model/chat_user.dart';
import '../model/room_data.dart';

///Methods
// sendMessage
// update final message
// get conversation messages
// conversation messages count
// increment conversation messages count
///

/// contain all Messages repositories
/// The functions of this class always return json as Map
/// Don't need to MessageService
abstract class MessageRepo {
  /// Const constructor
  const MessageRepo();

  ///to send a new message
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
      ///Configure the data to be sent
      final data = <String, dynamic>{
        ConstChatData.messageField: msg,
        ConstChatData.dateField: DateTime.now(),
        ConstChatData.userIdField: user.id.toString(),
      };

      await ConstChatData.chatCollectionReference
          .doc(roomData.id)
          .collection(ConstChatData.messagesCollectionName)
          .add(data);

      return null;
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in MessageRepo.sendMessage : $e');
      return e.toString();
    }
  }

  ///update final message to
  ///used in conversation to show what is the last message
  static Future<String> updateFinalMessage({
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
      ///Configure the data to be sent
      final jsonFinalMessage = {
        ConstChatData.messageField: msg,
        ConstChatData.dateField: DateTime.now(),
        ConstChatData.userIdField: user.id.toString(),
      };

      await ConstChatData.chatCollectionReference.doc(roomData.id).update(
        <String, dynamic>{ConstChatData.finalMessageField: jsonFinalMessage},
      );

      return null;
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in MessageRepo.updateFinalMessage : $e');
      return e.toString();
    }
  }

  ///get all conversations as stream of QuerySnapshot
  static Stream<QuerySnapshot> conversationMessages({
    @required RoomData roomData,
  }) {
    assert(roomData != null);
    assert(roomData.usable);

    try {
      return ConstChatData.chatCollectionReference
          .doc(roomData.id)
          .collection(ConstChatData.messagesCollectionName)
          .orderBy(ConstChatData.dateField)
          .limitToLast(ConstChatData.messagesPaginationLimit)
          .snapshots();
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in MessageRepo.conversationMessages : $e');
      return null;
    }
  }

  ///Get conversation Messages Count by room id
  static Future<int> conversationMessagesCount({
    @required RoomData roomData,
  }) async {
    assert(roomData != null);
    assert(roomData.usable);

    try {
      final d =
          await ConstChatData.chatCollectionReference.doc(roomData.id).get();

      final count = d?.data()[ConstChatData.countField] as int;

      return count ?? 0;
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log('Exception in MessageRepo.conversationMessagesCount : $e');
      return 0;
    }
  }

  ///Increment conversation messages Count by one
  static Future<String> incrementConversationMessagesCount({
    @required RoomData roomData,
  }) async {
    assert(roomData != null);
    assert(roomData.usable);

    try {
      await ConstChatData.chatCollectionReference.doc(roomData.id).update(
        <String, dynamic>{ConstChatData.countField: FieldValue.increment(1)},
      );
      return null;
    } catch (e) {
      log('Exception in MessageRepo.incrementConversationMessagesCount : $e');
      return e.toString();
    }
  }

  static Future<List<QueryDocumentSnapshot>> getMoreMessages({
    @required RoomData roomData,
    @required DocumentSnapshot lastDocumentSnapshot,
    @required int currentMsgLength,
  }) async {
    assert(roomData != null);
    assert(roomData.usable);

    assert(lastDocumentSnapshot != null);
    assert(currentMsgLength != null && currentMsgLength >= 0);

    try {
      final allMsgCount = await conversationMessagesCount(roomData: roomData);
      final count = allMsgCount - currentMsgLength;

      if (count > 0) {
        final q = await ConstChatData.chatCollectionReference
            .doc(roomData.id)
            .collection(ConstChatData.messagesCollectionName)
            .orderBy(ConstChatData.dateField, descending: true)
            .startAfterDocument(lastDocumentSnapshot)
            .limit(ConstChatData.messagesPaginationLimit)
            .get();

        return q.docs;
      }
      return <QueryDocumentSnapshot>[];
    } catch (e) {
      log('Exception in MessageRepo.getMoreMessages : $e');
      return <QueryDocumentSnapshot>[];
    }
  }
}
