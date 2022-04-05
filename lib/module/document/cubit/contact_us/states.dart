import 'package:flutter/material.dart';


abstract class ContactUSViewStates {
  const ContactUSViewStates();
}

class InitialState extends ContactUSViewStates {
  const InitialState() : super();
}

class HasInitState extends ContactUSViewStates {
  const HasInitState() : super();
}

class LoadingState extends ContactUSViewStates {
  const LoadingState() : super();
}

class EmptyState extends ContactUSViewStates {
  const EmptyState() : super();
}

class RefreshState extends ContactUSViewStates {
  const RefreshState() : super();
}

class IneffectiveErrorState extends ContactUSViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends ContactUSViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
