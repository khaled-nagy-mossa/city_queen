import 'package:flutter/material.dart';

import '../../../../model/user/user.dart';

abstract class AccountStates {
  final User user;

  const AccountStates({this.user});
}

class InitialState extends AccountStates {
  const InitialState();
}

class UpdatingProfileDataState extends AccountStates {
  const UpdatingProfileDataState() : super();
}

class UpdatedProfileDataState extends AccountStates {
  const UpdatedProfileDataState({User user}) : super(user: user);
}

class IneffectiveErrorState extends AccountStates {
  final String error;

  const IneffectiveErrorState({@required this.error});
}
