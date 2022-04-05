import 'package:flutter/material.dart';

abstract class SignInViewStates {
  String email;
  String password;

  SignInViewStates({this.email, this.password});
}

class InitialState extends SignInViewStates {
  InitialState({String email, String password})
      : super(email: email, password: password);
}

class LoadingState extends SignInViewStates {
  LoadingState({String email, String password})
      : super(email: email, password: password);
}

class ValidEmail extends SignInViewStates {
  ValidEmail({String email, String password})
      : super(email: email, password: password);
}

class InvalidEmail extends SignInViewStates {
  InvalidEmail({String email, String password})
      : super(email: email, password: password);
}

class ValidPassword extends SignInViewStates {
  ValidPassword({String email, String password})
      : super(email: email, password: password);
}

class InvalidPassword extends SignInViewStates {
  InvalidPassword({String email, String password})
      : super(email: email, password: password);
}

class VisiblePasswordState extends SignInViewStates {
  final bool vp;

  VisiblePasswordState({@required this.vp, String email, String password})
      : super(email: email, password: password);
}

class IneffectiveErrorState extends SignInViewStates {
  final String e;

  IneffectiveErrorState({@required this.e, String email, String password})
      : super(email: email, password: password);
}

class ExceptionState extends SignInViewStates {
  final String e;

  ExceptionState({@required this.e, String email, String password})
      : super(email: email, password: password);
}
