import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import '../common/const.dart';
import 'chat_user.dart';
import 'message.dart';
import 'room_data.dart';

class Conversation extends UsageCriteria {
  const Conversation({
    this.count,
    this.finalMessage,
    this.roomData,
    this.users,
    this.usersIds,
  });

  final int count;
  final Message finalMessage;
  final RoomData roomData;
  final List<ChatUser> users;
  final List<String> usersIds;

  Conversation copyWith({
    int count,
    Message finalMessage,
    RoomData roomData,
    List<ChatUser> users,
    List<String> usersIds,
  }) {
    try {
      return Conversation(
        count: count ?? this.count,
        finalMessage: finalMessage ?? this.finalMessage,
        roomData: roomData ?? this.roomData,
        usersIds: usersIds ?? this.usersIds,
        users: users ?? this.users,
      );
    } catch (e) {
      log('Exception in Conversation.copyWith : $e');
      return this;
    }
  }

  factory Conversation.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const Conversation();

      return Conversation.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Conversation.fromJson : $e');
      return const Conversation();
    }
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Conversation();

      return Conversation(
        count: json[ConstChatData.countField] as int,
        finalMessage: Message.fromMap(
          json[ConstChatData.finalMessageField] as Map<String, dynamic>,
        ),
        roomData: RoomData(id: json[ConstChatData.roomIdField] as String),
        usersIds: List<String>.from(
          ((json[ConstChatData.usersIdsField] ?? <Map>[]) as List).map<String>(
            (dynamic e) => e.toString(),
          ),
        ),
        users: json[ConstChatData.usersField] == null
            ? <ChatUser>[]
            : List<ChatUser>.from(
                ((json[ConstChatData.usersField] ?? <Map>[]) as List)
                    .map<ChatUser>(
                  (dynamic x) => ChatUser.fromMap(x as Map<String, dynamic>),
                ),
              ),
      );
    } catch (e) {
      log('Exception in Conversation.fromMap : $e');
      return const Conversation();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        ConstChatData.roomIdField: roomData?.id,
        ConstChatData.usersIdsField: usersIds,
        ConstChatData.usersField: users == null
            ? null
            : List<dynamic>.from(
                users.map<Map>((x) => x?.toMap() ?? <String, dynamic>{}),
              ),
        ConstChatData.finalMessageField: finalMessage?.toMap(),
      };
    } catch (e) {
      log('Exception in Conversation.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Conversation.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return roomData != null &&
          roomData.id != null &&
          users != null &&
          users.length >= 2 &&
          usersIds != null;
    } catch (e) {
      log('Exception in Conversation.unUsable : $e');
      return false;
    }
  }
}
