import 'package:flutter/material.dart';

abstract class FaqViewStates {
  const FaqViewStates();
}

class InitialState extends FaqViewStates {
  const InitialState() : super();
}

class HasInitState extends FaqViewStates {
  const HasInitState() : super();
}

class EmptyState extends FaqViewStates {
  const EmptyState() : super();
}
class LoadingState extends FaqViewStates {
  const LoadingState() : super();
}

class IneffectiveError extends FaqViewStates {
  final String error;

  const IneffectiveError({@required this.error}) : super();
}

class ExceptionState extends FaqViewStates {
  final String e;

  const ExceptionState({@required this.e}) : super();
}
