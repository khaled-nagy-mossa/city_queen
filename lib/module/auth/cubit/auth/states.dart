import 'package:flutter/cupertino.dart';

import '../../../../model/user/user.dart';

abstract class AuthStates {
  final User user;

  const AuthStates({this.user});
}

class InitialState extends AuthStates {
  const InitialState();
}

class SignedState extends AuthStates {
  const SignedState(User user) : super(user: user);
}

class SignOutState extends AuthStates {
  const SignOutState();
}

class IneffectiveErrorState extends AuthStates {
  final String error;

  const IneffectiveErrorState({@required this.error});
}
