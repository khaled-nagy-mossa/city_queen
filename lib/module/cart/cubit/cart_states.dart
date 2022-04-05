import 'package:flutter/material.dart';

import '../../../model/order/order.dart';
import '../../../model/order/order_branch.dart';
import '../../branch/model/branch_availability.dart';
import '../../product/model/variant.dart';

abstract class CartStates {
  final Order order;

  const CartStates({this.order});
}

class InitialState extends CartStates {
  const InitialState({Order order}) : super(order: order);
}

class ClearedCacheState extends CartStates {
  const ClearedCacheState({Order order}) : super(order: order);
}

class RefreshState extends CartStates {
  const RefreshState({Order order}) : super(order: order);
}

class LoadingState extends CartStates {
  const LoadingState({Order order}) : super(order: order);
}

class EmptyState extends CartStates {
  const EmptyState({Order order}) : super(order: order);
}

class IneffectiveErrorState extends CartStates {
  final String error;

  const IneffectiveErrorState({@required this.error, Order order})
      : super(order: order);
}

class ExceptionState extends CartStates {
  final String e;

  const ExceptionState({@required this.e, Order order}) : super(order: order);
}

class StartClearingState extends CartStates {
  const StartClearingState({Order order}) : super(order: order);
}

class EndClearingState extends CartStates {
  const EndClearingState({Order order}) : super(order: order);
}

class HasUpdatedState extends CartStates {
  const HasUpdatedState({Order order}) : super(order: order);
}

class ShowAvailableBranchesState extends CartStates {
  final List<BranchAvailability> branches;

  const ShowAvailableBranchesState({@required this.branches, Order order})
      : super(order: order);
}

class BranchHasChangedState extends CartStates {
  final OrderBranch branch;

  const BranchHasChangedState({@required this.branch, Order order})
      : super(order: order);
}

class RemoveBranchState extends CartStates {
  const RemoveBranchState({Order order}) : super(order: order);
}

class AddingVariantState extends CartStates {
  final Variant variant;

  const AddingVariantState({@required this.variant, Order order})
      : super(order: order);
}

class VariantAddedState extends CartStates {
  final Variant variant;

  const VariantAddedState({@required this.variant, Order order})
      : super(order: order);
}
