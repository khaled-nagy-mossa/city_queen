import 'package:flutter/material.dart';

import '../../model/product.dart';

/// States [
/// InitialState, HasInitState,
/// EmptyState,
/// IneffectiveErrorState, ExceptionState,
/// ]

abstract class ProductViewStates {
  final Product product;

  const ProductViewStates({this.product});
}

class InitialState extends ProductViewStates {
  const InitialState({Product product}) : super(product: product);
}

class HasInitState extends ProductViewStates {
  const HasInitState({Product product}) : super(product: product);
}

class EmptyState extends ProductViewStates {
  const EmptyState({Product product}) : super(product: product);
}

class LoadingState extends ProductViewStates {
  const LoadingState({Product product}) : super(product: product);
}

class IneffectiveErrorState extends ProductViewStates {
  final String error;

  IneffectiveErrorState({@required this.error, Product product})
      : super(product: product);
}

class ExceptionState extends ProductViewStates {
  final String error;

  ExceptionState({@required this.error, Product product})
      : super(product: product);
}

////////////////////////////////////////////////////////////////////////////////
///will change that
class ChangeMyReviewMember extends ProductViewStates {
  ChangeMyReviewMember({Product product}) : super(product: product);
}
