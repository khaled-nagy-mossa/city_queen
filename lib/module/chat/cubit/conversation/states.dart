import 'package:flutter/material.dart';

abstract class ConversationStates {
  const ConversationStates();
}

class InitialState extends ConversationStates {
  const InitialState() : super();
}

class LoadingState extends ConversationStates {
  const LoadingState() : super();
}

class FetchingMoreState extends ConversationStates {
  const FetchingMoreState() : super();
}

class FetchedMoreState extends ConversationStates {
  const FetchedMoreState() : super();
}

class SendingMessageState extends ConversationStates {
  const SendingMessageState() : super();
}

class MessageSentState extends ConversationStates {
  final String value;

  const MessageSentState({@required this.value}) : super();
}

class MessageChangedState extends ConversationStates {
  const MessageChangedState() : super();
}

class IneffectiveErrorState extends ConversationStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}
