import 'package:flutter/material.dart';
import '../../model/server/forget_password.dart';

abstract class ForgetPasswordViewStates {
  final String email;
  final String password;

  const ForgetPasswordViewStates({this.email, this.password});
}

class InitialState extends ForgetPasswordViewStates {
  InitialState({String email, String password})
      : super(email: email, password: password);
}

class MessageSendState extends ForgetPasswordViewStates {
  final ForgetPassword model;

  MessageSendState({@required this.model, String email, String password})
      : super(email: email, password: password);
}

class LoadingState extends ForgetPasswordViewStates {
  LoadingState({String email, String password})
      : super(email: email, password: password);
}

class ValidEmail extends ForgetPasswordViewStates {
  ValidEmail({String email, String password})
      : super(email: email, password: password);
}

class InvalidEmail extends ForgetPasswordViewStates {
  InvalidEmail({String email, String password})
      : super(email: email, password: password);
}

class IneffectiveErrorState extends ForgetPasswordViewStates {
  final String e;

  IneffectiveErrorState({@required this.e, String email, String password})
      : super(email: email, password: password);
}

class ExceptionState extends ForgetPasswordViewStates {
  final String e;

  ExceptionState({@required this.e, String email, String password})
      : super(email: email, password: password);
}
