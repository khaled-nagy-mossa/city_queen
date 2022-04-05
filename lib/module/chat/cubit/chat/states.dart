import 'package:flutter/material.dart';

import '../../model/conversation.dart';

abstract class ChatStates {
  const ChatStates();
}

class InitialState extends ChatStates {
  const InitialState() : super();
}

class LoadingState extends ChatStates {
  const LoadingState() : super();
}

class RoomCreatedState extends ChatStates {
  final Conversation conversation;

  const RoomCreatedState({@required this.conversation}) : super();
}

class IneffectiveErrorState extends ChatStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}
