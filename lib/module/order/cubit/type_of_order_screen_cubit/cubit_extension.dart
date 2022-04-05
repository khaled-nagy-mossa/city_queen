import '../../../../model/order/order.dart';
import '../../../../model/order/order_list.dart';
import 'cubit.dart';

extension TypeOfOrdersViewCubitExtension on TypeOfOrdersViewCubit {
  OrderList get orderList {
    return orderList ?? const OrderList(count: 0, orders: <Order>[]);
  }

  void increaseOffset() {
    param = param.copyWith(offset: (param?.offset ?? -10) + 10);
  }

  void decreaseOffset() {
    param = param.copyWith(offset: (param?.offset ?? 10) - 10);
  }

  void resetOffset() {
    param = param.copyWith(offset: 0);
  }
}
