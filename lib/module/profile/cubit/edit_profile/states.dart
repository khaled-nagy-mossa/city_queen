import 'package:flutter/cupertino.dart';

abstract class EditProfileViewStates {
  const EditProfileViewStates();
}

class InitialState extends EditProfileViewStates {
  const InitialState() : super();
}

class NameChangedState extends EditProfileViewStates {
  const NameChangedState() : super();
}

class EmailChangedState extends EditProfileViewStates {
  const EmailChangedState() : super();
}

class PhoneChangedState extends EditProfileViewStates {
  const PhoneChangedState() : super();
}

class IneffectiveErrorState extends EditProfileViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}
