import 'package:flutter/material.dart';

abstract class ChangePasswordViewStates {
  const ChangePasswordViewStates();
}

class InitialState extends ChangePasswordViewStates {
  const InitialState() : super();
}

class PasswordChangedState extends ChangePasswordViewStates {
  const PasswordChangedState() : super();
}

class LoadingState extends ChangePasswordViewStates {
  const LoadingState() : super();
}

class IneffectiveErrorState extends ChangePasswordViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends ChangePasswordViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
