import 'dart:convert';
import 'dart:developer';
import '../usage_criteria.dart';
import 'order.dart';

class OrderList implements UsageCriteria {
  const OrderList({this.count, this.orders});

  final int count;
  final List<Order> orders;

  OrderList copyWith({int count, List<Order> orders}) {
    try {
      return OrderList(
        count: count ?? this.count,
        orders: orders ?? this.orders,
      );
    } catch (e) {
      log('Exception in OrderList.copyWith : $e');
      return const OrderList();
    }
  }

  factory OrderList.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderList();
    try {
      return OrderList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderList.fromJson : $e');
      return const OrderList();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const OrderList();

      return OrderList(
        count: json['count'] as int,
        orders: List<Order>.from(
          ((json['orders'] ?? <Map>[]) as List).map<Order>(
            (dynamic x) => Order.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in OrderList.fromMap : $e');
      return const OrderList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'count': count,
        'orders': List<Order>.from(orders?.map<Map>((x) => x.toMap())),
      };
    } catch (e) {
      log('Exception in OrderList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  // TODO: implement unUsable
  bool get unusable {
    return count == null || count == 0 || orders == null || orders.isEmpty;
  }

  @override
  // TODO: implement usable
  bool get usable => throw UnimplementedError();
}
