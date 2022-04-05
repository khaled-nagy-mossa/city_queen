import 'package:flutter/material.dart';

/// States [
/// InitialState,
/// LoadingVariantState, VariantLoadedState
/// IneffectiveErrorState, ExceptionState,
/// ]

abstract class VariantStates {
  const VariantStates();
}

class InitialState extends VariantStates {
  const InitialState() : super();
}

class LoadingVariantState extends VariantStates {
  const LoadingVariantState() : super();
}

class VariantLoadedState extends VariantStates {
  const VariantLoadedState() : super();
}

class IneffectiveErrorState extends VariantStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends VariantStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
