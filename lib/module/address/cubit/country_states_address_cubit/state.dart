import 'package:flutter/cupertino.dart';

abstract class CountryStatesAddressStates {
  const CountryStatesAddressStates();
}

class InitialState extends CountryStatesAddressStates {
  const InitialState() : super();
}

class HasInitState extends CountryStatesAddressStates {
  const HasInitState() : super();
}

class LoadingState extends CountryStatesAddressStates {
  const LoadingState() : super();
}

class EmptyState extends CountryStatesAddressStates {
  const EmptyState() : super();
}

class FilterChangedState extends CountryStatesAddressStates {
  const FilterChangedState() : super();
}

class IneffectiveErrorState extends CountryStatesAddressStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends CountryStatesAddressStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
