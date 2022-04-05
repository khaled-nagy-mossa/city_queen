import 'package:flutter/material.dart';

/// States [
/// InitialState, HasInitState,
/// FetchingMoreState, HasFetchedMoreState,
/// LoadingState, EmptyState,
/// IneffectiveErrorState, ExceptionState,
/// ]

abstract class ProductsStates {
  const ProductsStates();
}

class InitialState extends ProductsStates {
  const InitialState() : super();
}

class HasInitState extends ProductsStates {
  const HasInitState() : super();
}

class FetchingMoreState extends ProductsStates {
  const FetchingMoreState() : super();
}

class HasFetchedMoreState extends ProductsStates {
  const HasFetchedMoreState() : super();
}

class LoadingState extends ProductsStates {
  const LoadingState() : super();
}

class EmptyState extends ProductsStates {
  const EmptyState() : super();
}

class IneffectiveErrorState extends ProductsStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends ProductsStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
