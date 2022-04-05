import 'package:flutter/material.dart';

abstract class SignUpViewStates {
  String email;
  String password;

  SignUpViewStates({this.email, this.password});
}

class InitialState extends SignUpViewStates {
  InitialState({String email, String password})
      : super(email: email, password: password);
}

class LoadingState extends SignUpViewStates {
  LoadingState({String email, String password})
      : super(email: email, password: password);
}

class ValidEmail extends SignUpViewStates {
  ValidEmail({String email, String password})
      : super(email: email, password: password);
}

class InvalidEmail extends SignUpViewStates {
  InvalidEmail({String email, String password})
      : super(email: email, password: password);
}

class ValidPassword extends SignUpViewStates {
  ValidPassword({String email, String password})
      : super(email: email, password: password);
}

class ValidConfirmPassword extends SignUpViewStates {
  ValidConfirmPassword({String email, String password})
      : super(email: email, password: password);
}

class InvalidPassword extends SignUpViewStates {
  InvalidPassword({String email, String password})
      : super(email: email, password: password);
}

class InvalidConfirmPassword extends SignUpViewStates {
  InvalidConfirmPassword({String email, String password})
      : super(email: email, password: password);
}

class CountryChangedState extends SignUpViewStates {
  CountryChangedState({String email, String password})
      : super(email: email, password: password);
}
class StateLocationChangedState extends SignUpViewStates {
  StateLocationChangedState({String email, String password})
      : super(email: email, password: password);
}

class VisiblePasswordState extends SignUpViewStates {
  final bool vp;

  VisiblePasswordState({@required this.vp, String email, String password})
      : super(email: email, password: password);
}

class IneffectiveErrorState extends SignUpViewStates {
  final String e;

  IneffectiveErrorState({@required this.e, String email, String password})
      : super(email: email, password: password);
}

class ExceptionState extends SignUpViewStates {
  final String e;

  ExceptionState({@required this.e, String email, String password})
      : super(email: email, password: password);
}
