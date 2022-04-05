import 'package:flutter/material.dart';

abstract class FavouritesViewStates {
  const FavouritesViewStates();
}

class InitialState extends FavouritesViewStates {
  const InitialState() : super();
}

class HasInitState extends FavouritesViewStates {
  const HasInitState() : super();
}

class AddingVariantState extends FavouritesViewStates {
  final int variantId;

  const AddingVariantState({@required this.variantId}) : super();
}

class AddedVariantState extends FavouritesViewStates {
  final int variantId;

  const AddedVariantState({@required this.variantId}) : super();
}

class RemovingVariantState extends FavouritesViewStates {
  final int variantId;

  const RemovingVariantState({@required this.variantId}) : super();
}

class LoadingStates extends FavouritesViewStates {
  const LoadingStates() : super();
}

class RefreshState extends FavouritesViewStates {
  const RefreshState() : super();
}

class EmptyState extends FavouritesViewStates {
  const EmptyState() : super();
}

class IneffectiveError extends FavouritesViewStates {
  final String error;

  const IneffectiveError({@required this.error});
}

class ExceptionState extends FavouritesViewStates {
  final String e;

  const ExceptionState({@required this.e});
}
