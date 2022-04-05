import 'package:flutter/material.dart';

import '../../../../model/order/order.dart';

abstract class CheckOrderViewStates {
  final Order order;

  const CheckOrderViewStates({this.order});
}

class InitialState extends CheckOrderViewStates {
  const InitialState({Order order}) : super(order: order);
}

class LoadingState extends CheckOrderViewStates {
  const LoadingState({Order order}) : super(order: order);
}

class HasInitState extends CheckOrderViewStates {
  const HasInitState({Order order}) : super(order: order);
}

class EmptyState extends CheckOrderViewStates {
  const EmptyState({Order order}) : super(order: order);
}

class RefreshState extends CheckOrderViewStates {
  const RefreshState({Order order}) : super(order: order);
}

class IneffectiveErrorState extends CheckOrderViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error, Order order})
      : super(order: order);
}

class ExceptionState extends CheckOrderViewStates {
  final String error;

  const ExceptionState({@required this.error, Order order})
      : super(order: order);
}
