import 'package:flutter/material.dart';

/// States [
/// InitialState, HasInitState,
/// FetchingMoreState, HasFetchedMoreState,
/// LoadingState, EmptyState,
/// IneffectiveErrorState, ExceptionState,
/// ]

abstract class CategoriesViewStates {
  const CategoriesViewStates();
}

class InitialState extends CategoriesViewStates {
  const InitialState() : super();
}

class HasInitState extends CategoriesViewStates {
  const HasInitState() : super();
}

class LoadingState extends CategoriesViewStates {
  const LoadingState() : super();
}

class EmptyState extends CategoriesViewStates {
  const EmptyState() : super();
}

class SearchState extends CategoriesViewStates {
  const SearchState() : super();
}

class HasFetchedMoreState extends CategoriesViewStates {
  const HasFetchedMoreState() : super();
}

class FetchingDataState extends CategoriesViewStates {
  const FetchingDataState() : super();
}

class IneffectiveErrorState extends CategoriesViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends CategoriesViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
