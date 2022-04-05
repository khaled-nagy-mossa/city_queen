import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/usage_criteria.dart';
import '../../model/chat_user.dart';
import '../../model/conversation.dart';
import '../../repositories/service.dart';
import 'states.dart';

///this is not chat view cubit
class ChatCubit extends Cubit<ChatStates> implements UsageCriteria {
  final ChatUser chatUser;

  ChatCubit({
    @required this.chatUser,
  })  : assert(chatUser != null),
        super(const InitialState());

  factory ChatCubit.get(BuildContext context) {
    return BlocProvider.of<ChatCubit>(context);
  }

  Future<Conversation> startChatWith(ChatUser user) async {
    try {
      await Future<void>.delayed(Duration.zero);
      emit(const LoadingState());

      final roomData = await ChatService.startRoomWith(
        me: chatUser,
        user: user,
      );
      if (roomData == null || roomData.unusable) throw 'Unknown Exception';

      final Object result = await ChatService.conversation(room: roomData);

      if (result is! Conversation) {
        throw result.toString();
      } else {
        emit(RoomCreatedState(conversation: result as Conversation));
        return result as Conversation;
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
      return null;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ChatCubit.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return chatUser != null && chatUser.usable;
    } catch (e) {
      log('Exception in ChatCubit.unUsable : $e');
      return false;
    }
  }
}
