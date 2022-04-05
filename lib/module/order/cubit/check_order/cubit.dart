import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/order/order.dart';
import '../../repositories/service.dart';
import 'cubit_extension.dart';
import 'states.dart';

class CheckOrderViewCubit extends Cubit<CheckOrderViewStates> {
  Order order;

  CheckOrderViewCubit(int orderId) : super(const InitialState()) {
    init(orderId);
  }

  factory CheckOrderViewCubit.get(BuildContext context) {
    return BlocProvider.of<CheckOrderViewCubit>(context);
  }

  Future<void> init(int orderId) async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await OrderService.orderById(orderId);

      if (result is String) throw result;

      if (result is Order) {
        order = result;

        if (hasData) {
          emit(const HasInitState());
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(order: order, error: e.toString()));
      return;
    }
  }
}
