import 'package:flutter/material.dart';

abstract class HomeViewStates {
  const HomeViewStates();
}

class InitialState extends HomeViewStates {
  const InitialState();
}

class HasInitState extends HomeViewStates {
  const HasInitState() : super();
}

class IneffectiveErrorState extends HomeViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends HomeViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
