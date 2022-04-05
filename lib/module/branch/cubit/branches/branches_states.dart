import 'package:flutter/material.dart';

abstract class BranchesViewStates {
  const BranchesViewStates();
}

class InitialState extends BranchesViewStates {
  const InitialState() : super();
}

class HasInitState extends BranchesViewStates {
  const HasInitState() : super();
}

class LoadingState extends BranchesViewStates {
  const LoadingState() : super();
}

class EmptyState extends BranchesViewStates {
  const EmptyState() : super();
}

class FetchingDataState extends BranchesViewStates {
  const FetchingDataState() : super();
}

class HasFetchedDataState extends BranchesViewStates {
  const HasFetchedDataState() : super();
}

class IneffectiveErrorState extends BranchesViewStates {
  final String error;

  IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends BranchesViewStates {
  final String error;

  ExceptionState({@required this.error}) : super();
}
