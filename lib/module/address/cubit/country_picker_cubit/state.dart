import 'package:flutter/cupertino.dart';

abstract class CountryPickerViewStates {
  const CountryPickerViewStates();
}

class InitialState extends CountryPickerViewStates {
  const InitialState() : super();
}

class HasInitState extends CountryPickerViewStates {
  const HasInitState() : super();
}

class LoadingState extends CountryPickerViewStates {
  const LoadingState() : super();
}

class EmptyState extends CountryPickerViewStates {
  const EmptyState() : super();
}

class FilterChangedState extends CountryPickerViewStates {
  const FilterChangedState() : super();
}

class IneffectiveErrorState extends CountryPickerViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends CountryPickerViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
