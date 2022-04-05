import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/order/extension/order_list_extension.dart';
import '../../../../model/order/order.dart';
import '../../../../model/order/order_list.dart';
import '../../model/orders_param.dart';
import '../../repositories/service.dart';
import 'cubit_extension.dart';
import 'states.dart';

class TypeOfOrdersViewCubit extends Cubit<TypeOgOrderScreenStates> {
  OrderList _orderList;
  OrdersListParam param;

  OrderList get orderList {
    return _orderList ?? const OrderList(count: 0, orders: <Order>[]);
  }

  TypeOfOrdersViewCubit(this.param) : super(const InitialState()) {
    param = param.copyWith(offset: 0);
    init();
  }

  factory TypeOfOrdersViewCubit.get(BuildContext context) {
    return BlocProvider.of<TypeOfOrdersViewCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await OrderService.orders(ordersParam: param);

      if (result is String) throw result;

      if (result is OrderList) {
        _orderList = result;

        if (_orderList == null || _orderList.empty) {
          emit(const EmptyState());
        } else {
          emit(const HasInitState());
        }
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> fetchMore() async {
    if (state is FetchingDataState) return;

    if (orderList.orders.length >= orderList.count) {
      return;
    }

    try {
      await Future<void>.delayed(Duration.zero); //to enable consumer

      emit(const FetchingDataState());

      increaseOffset();

      final Object result = await OrderService.orders(ordersParam: param);

      if (result is String) throw result;

      if (result is OrderList) {
        _orderList?.orders?.addAll(result?.orders ?? []);
        emit(const HasInitState());
      }
    } catch (e) {
      decreaseOffset();
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(Duration.zero);
    emit(const LoadingState());
    await init();
  }
}
