import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/order/order.dart';
import '../../controller/const.dart';
import '../../repositories/service.dart';
import 'states.dart';

class OrderViewCubit extends Cubit<OrderViewStates> {
  final OrderType orderType;
  Order _order;
  int _orderId;

  Order get order => _order;

  int get orderId {
    return _orderId ?? order.id;
  }

  OrderViewCubit({this.orderType, Order order, int orderId})
      : super(const InitialState()) {
    _order = order;
    _orderId = orderId ?? order.id;

    init();
  }

  factory OrderViewCubit.get(BuildContext context) =>
      BlocProvider.of<OrderViewCubit>(context);

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero); //to enable consumer
      if (_order != null) {
        emit(const HasInitState());
      }

      await Future<void>.delayed(Duration.zero); //to enable consumer

      emit(const LoadingState());

      await _getOrderById();
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> _getOrderById() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await OrderService.orderById(_orderId);

      if (result is String) throw result;

      if (result is Order) {
        _order = result;
        emit(const HasInitState());
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(Duration.zero);
    emit(const LoadingState());
    await init();
  }
}
