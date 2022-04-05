import 'dart:developer';

class OrdersListParam {
  const OrdersListParam({
    this.orderTypeParameter,
    this.offset,
    this.limit = 10,
  });

  final String orderTypeParameter;
  final int offset;
  final int limit;

  OrdersListParam copyWith({
    String orderTypeParameter,
    int offset,
    int limit,
  }) {
    try {
      return OrdersListParam(
        orderTypeParameter: orderTypeParameter ?? this.orderTypeParameter,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
      );
    } catch (e) {
      log('Exception in OrdersParam.copyWith : $e');
      return this;
    }
  }

  /// to parse params and get as url
  String get parse {
    var url = '';

    ///add params
    try {
      url += '?';

      if (limit != null && offset != null) {
        url += 'limit=$limit&offset=$offset&';
      }

      ///Erase extra marks
      if (url[url.length - 1] == '&') {
        url = url.substring(0, url.length - 1);
      }
      if (url[url.length - 1] == '?') {
        url = url.substring(0, url.length - 1);
      }

      return url;
    } catch (e) {
      log('Exception in OrdersParam.parse :$e');
      return url;
    }
  }
}
