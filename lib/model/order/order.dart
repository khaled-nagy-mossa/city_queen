import 'dart:convert';
import 'dart:developer';
import '../usage_criteria.dart';
import 'order_branch.dart';
import 'order_customer.dart';
import 'order_delivery_man.dart';
import 'order_line.dart';
import 'order_shipping_address.dart';

///i use and extension methods in order_extension file
class Order implements UsageCriteria {
  const Order({
    this.id,
    this.reference,
    this.branch,
    this.customer,
    this.shippingAddress,
    this.deliveryMan,
    this.amount,
    this.taxes,
    this.total,
    this.currency,
    this.currencySymbol,
    this.lines,
    this.status,
    this.paymentLink,
    this.paymentState,
  });

  final int id;
  final String reference;
  final OrderBranch branch;
  final OrderCustomer customer;
  final OrderShippingAddress shippingAddress;
  final OrderDeliveryMan deliveryMan;
  final double amount;
  final double taxes;
  final double total;
  final String currency;
  final String currencySymbol;
  final List<OrderLine> lines;
  final String status;
  final String paymentLink;
  final String paymentState;

  Order copyWith({
    int id,
    String reference,
    OrderBranch branch,
    OrderCustomer customer,
    OrderShippingAddress shippingAddress,
    OrderDeliveryMan deliveryMan,
    double amount,
    double taxes,
    double total,
    String currency,
    String currencySymbol,
    List<OrderLine> lines,
    String status,
    String paymentLink,
    String paymentState,
  }) {
    try {
      return Order(
        id: id ?? this.id,
        reference: reference ?? this.reference,
        branch: branch ?? this.branch,
        customer: customer ?? this.customer,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        deliveryMan: deliveryMan ?? this.deliveryMan,
        amount: amount ?? this.amount,
        taxes: taxes ?? this.taxes,
        total: total ?? this.total,
        currency: currency ?? this.currency,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        lines: lines ?? this.lines,
        status: status ?? this.status,
        paymentLink: paymentLink ?? this.paymentLink,
        paymentState: paymentState ?? this.paymentState,
      );
    } catch (e) {
      log('Exception in Order.copyWith : $e');
      return const Order();
    }
  }

  factory Order.fromJson(String str) {
    if (str == null || str.isEmpty) return const Order();

    try {
      return Order.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Order.fromJson : $e');
      return const Order();
    }
  }

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Order();

      return Order(
        id: json['id'] as int,
        reference: json['reference'] as String,
        branch: OrderBranch.fromMap(
          (json['branch'] ?? <String ,dynamic>{}) as Map<String, dynamic>,
        ),
        customer: OrderCustomer.fromMap(
          (json['customer'] ??<String ,dynamic> {}) as Map<String, dynamic>,
        ),
        shippingAddress: OrderShippingAddress.fromMap(
          (json['shipping_address'] ??<String ,dynamic> {}) as Map<String, dynamic>,
        ),
        deliveryMan: OrderDeliveryMan.fromMap(
          (json['delivery_man'] ?? <String ,dynamic>{}) as Map<String, dynamic>,
        ),
        amount: json['amount']?.toDouble() as double,
        taxes: json['taxes']?.toDouble() as double,
        total: json['total']?.toDouble() as double,
        currency: json['currency'] as String,
        currencySymbol: json['currency_symbol'] as String,
        lines: List<OrderLine>.from(
          ((json['lines'] ?? <Map>[]) as List).map<OrderLine>(
            (dynamic x) => OrderLine.fromMap(x as Map<String, dynamic>),
          ),
        ),
        status: json['status'] as String,
        paymentLink: json['payment_link'] as String,
        paymentState: json['payment_state'] as String,
      );
    } catch (e) {
      log('Exception in Order.fromMap : $e');
      return const Order();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      final temp = <String, dynamic>{
        'id': id,
        'reference': reference,
        'branch': branch?.toMap(),
        'customer': customer?.toMap(),
        'shipping_address': shippingAddress?.toMap(),
        'delivery_man': deliveryMan?.toMap(),
        'amount': amount,
        'taxes': taxes,
        'total': total,
        'currency': currency,
        'currency_symbol': currencySymbol,
        'status': status,
        'payment_link': paymentLink,
        'payment_state': paymentState,
      };
      if (lines != null) {
        temp['lines'] = List<Map<String, dynamic>>.from(
          lines?.map<Map>((x) => x?.toMap()),
        );
      }
      return temp;
    } catch (e) {
      log('Exception in Order.toMap :$e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      //write your logic the logic here [...waiting]
      return true;
    } catch (e) {
      log('Exception in Order.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    return !usable;
  }
}
