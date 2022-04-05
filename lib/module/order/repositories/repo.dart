import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../../../common/const/app_data.dart';
import '../config/config.dart';
import '../model/orders_param.dart';

abstract class OrderRepo {
  const OrderRepo();

  static Future<SuperResponseModel> orders(
      {@required OrdersListParam param}) async {
    assert(param != null);

    final bodyData = <String, dynamic>{
      'for_user': AppData.userRole,
      'status': param.orderTypeParameter,
    };

    var url = OrderAPIs.orderList;
    url += param.parse;

    return HttpHelper.simpleRequest(HttpHelper.post(HttpHelper.url(url),
        header: await API.header(), body: json.encoder.convert(bodyData)));
  }

  static Future<SuperResponseModel> getOrder({
    @required int orderId,
  }) async {
    assert(orderId != null);

    return HttpHelper.simpleRequest(
      HttpHelper.getWithBodyData(
        HttpHelper.url(OrderAPIs.getOrder),
        header: await API.header(),
        body: ''' {\r\n "order_id": $orderId\r\n }''',
      ),
    );
  }

  static Future<SuperResponseModel> updateOrderAddress({
    @required int orderId,
    @required int addressId,
  }) async {
    assert(orderId != null);
    assert(addressId != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(OrderAPIs.updateOrderAddress),
        header: await API.header(),
        body: json.encode({'order_id': orderId, 'address_id': addressId}),
      ),
    );
  }
}
