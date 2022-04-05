import 'package:flutter/cupertino.dart';

abstract class TypeOgOrderScreenStates {
  const TypeOgOrderScreenStates();
}

class InitialState extends TypeOgOrderScreenStates {
  const InitialState() : super();
}

class HasInitState extends TypeOgOrderScreenStates {
  const HasInitState() : super();
}

class EmptyState extends TypeOgOrderScreenStates {
  const EmptyState() : super();
}

class LoadingState extends TypeOgOrderScreenStates {
  const LoadingState() : super();
}

class FetchingDataState extends TypeOgOrderScreenStates {
  const FetchingDataState() : super();
}

class IneffectiveErrorState extends TypeOgOrderScreenStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends TypeOgOrderScreenStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
