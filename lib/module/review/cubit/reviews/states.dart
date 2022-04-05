import 'package:flutter/material.dart';

abstract class ReviewViewStates {
  const ReviewViewStates();
}

class InitialState extends ReviewViewStates {
  const InitialState() : super();
}

class HasInitState extends ReviewViewStates {
  const HasInitState();
}

class FetchingDataState extends ReviewViewStates {
  const FetchingDataState() : super();
}

class HasFetchedMoreState extends ReviewViewStates {
  const HasFetchedMoreState() : super();
}

class LoadingState extends ReviewViewStates {
  const LoadingState() : super();
}

class EmptyState extends ReviewViewStates {
  const EmptyState() : super();
}

class IneffectiveErrorState extends ReviewViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends ReviewViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
