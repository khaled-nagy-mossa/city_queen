import 'package:flutter/material.dart';

abstract class DocumentViewStates {
  const DocumentViewStates();
}

class InitialState extends DocumentViewStates {
  const InitialState() : super();
}

class LoadingState extends DocumentViewStates {
  const LoadingState() : super();
}

class DataLoadedState extends DocumentViewStates {
  const DataLoadedState() : super();
}

class EmptyState extends DocumentViewStates {
  const EmptyState() : super();
}

class RefreshState extends DocumentViewStates {
  const RefreshState() : super();
}

class IneffectiveErrorState extends DocumentViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends DocumentViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
