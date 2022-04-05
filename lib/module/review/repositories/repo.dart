import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../../review/model/reviews_params.dart';
import '../config/config.dart';

abstract class ReviewRepo {
  const ReviewRepo();

  //get all product Reviews
  // header : Content-Type application/json
  static Future<SuperResponseModel> reviews(ReviewsParams params) async {
    assert(params != null);

    var url = ReviewAPIs.reviews;
    url += params.parse;

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  //to add new review to product
  // header : Content-Type application/json / AUTHORIZATION Bearer Token
  static Future<SuperResponseModel> addReview(
      {@required Map<String, dynamic> data}) async {
    assert(data != null);

    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(ReviewAPIs.addReview),
        header: await API.header(),
        body: json.encoder.convert(data)));
  }
}
