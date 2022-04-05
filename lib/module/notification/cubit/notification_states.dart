import 'package:flutter/material.dart';

abstract class NotificationViewStates {
  const NotificationViewStates();
}

class InitialState extends NotificationViewStates {
  const InitialState() : super();
}

class HasInitState extends NotificationViewStates {
  const HasInitState() : super();
}

class LoadingState extends NotificationViewStates {
  const LoadingState() : super();
}

class EmptyState extends NotificationViewStates {
  const EmptyState() : super();
}

class NotificationDeletedState extends NotificationViewStates {
  const NotificationDeletedState();
}

class RefreshState extends NotificationViewStates {
  const RefreshState();
}

class IneffectiveErrorState extends NotificationViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends NotificationViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
