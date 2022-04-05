import 'package:flutter/cupertino.dart';

abstract class OrderViewStates {
  const OrderViewStates();
}

class InitialState extends OrderViewStates {
  const InitialState() : super();
}

class HasInitState extends OrderViewStates {
  const HasInitState() : super();
}

class LoadingState extends OrderViewStates {
  const LoadingState() : super();
}

class IneffectiveErrorState extends OrderViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends OrderViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
