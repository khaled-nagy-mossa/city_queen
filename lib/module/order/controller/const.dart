import '../model/order_type_tab_model.dart';

enum OrderType { draft, sale, prepare, inDelivery, done, all, cancel }

abstract class OrderStagesHelper {
  const OrderStagesHelper();

  static const driverOrderTypeTabs = <OrderTypeTapModel>[
    OrderTypeTapModel(
      orderType: OrderType.inDelivery,
      orderTypeParameter: 'in_delivery',
      title: 'In Delivery',
    ),
    OrderTypeTapModel(
      orderType: OrderType.done,
      orderTypeParameter: 'done',
      title: 'Delivered',
    ),
    OrderTypeTapModel(
      orderType: OrderType.all,
      orderTypeParameter: '',
      title: 'All',
    ),
  ];

  static const orderTypeTabs = <OrderTypeTapModel>[
    OrderTypeTapModel(
      orderType: OrderType.draft,
      orderTypeParameter: 'draft',
      title: 'New',
    ),
    OrderTypeTapModel(
      orderType: OrderType.sale,
      orderTypeParameter: 'sale',
      title: 'Confirmed',
    ),
    OrderTypeTapModel(
      orderType: OrderType.prepare,
      orderTypeParameter: 'prepare',
      title: 'preparing',
    ),
    OrderTypeTapModel(
      orderType: OrderType.inDelivery,
      orderTypeParameter: 'in_delivery',
      title: 'In Delivery',
    ),
    OrderTypeTapModel(
      orderType: OrderType.done,
      orderTypeParameter: 'done',
      title: 'Delivered',
    ),
    OrderTypeTapModel(
      orderType: OrderType.all,
      orderTypeParameter: '',
      title: 'All',
    ),
    OrderTypeTapModel(
      orderType: OrderType.cancel,
      orderTypeParameter: 'cancel',
      title: 'Canceled',
    ),
  ];

  static OrderTypeTapModel orderTypeBy({
    String title = '',
    String orderTypeParameter = '',
    OrderType orderType,
  }) {
    assert(title != null || orderTypeParameter != null || orderType != null,
        'you must pass any argument to get order type tab model object');

    for (final temp in orderTypeTabs) {
      if (title != null && temp.title.toLowerCase() == title.toLowerCase()) {
        return temp;
      }
      if (orderTypeParameter != null &&
          temp.orderTypeParameter.toLowerCase() ==
              orderTypeParameter.toLowerCase()) {
        return temp;
      }

      if (temp.orderType == orderType) {
        return temp;
      }
    }
    return null;
  }
}
