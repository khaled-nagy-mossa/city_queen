import 'package:flutter/material.dart';

import '../../model/address.dart';

abstract class UserAddressesState {
  const UserAddressesState();
}

class InitialState extends UserAddressesState {
  const InitialState() : super();
}

class HasInitState extends UserAddressesState {
  const HasInitState() : super();
}

class LoadingState extends UserAddressesState {
  const LoadingState() : super();
}

class AddressAddedState extends UserAddressesState {
  final Address address;

  const AddressAddedState({@required this.address}) : super();
}

class AddressDeletedState extends UserAddressesState {
  const AddressDeletedState() : super();
}

class EmptyState extends UserAddressesState {
  const EmptyState() : super();
}

class IneffectiveErrorState extends UserAddressesState {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends UserAddressesState {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
