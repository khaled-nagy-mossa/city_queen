import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class FavouriteRepo {
  const FavouriteRepo();

  static Future<SuperResponseModel> favorites() async {
    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(FavouriteAPIs.favorites),
        header: await API.header(),
        body: json.encoder.convert(<String ,dynamic>{}),
      ),
    );
  }

  static Future<SuperResponseModel> addToFavorites({
    @required int variantId,
  }) async {
    assert(variantId != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(FavouriteAPIs.addToFavorites),
        header: await API.header(),
        body: json.encoder.convert({'variant_id': variantId}),
      ),
    );
  }

  static Future<SuperResponseModel> removeFavorites({
    @required int variantId,
  }) async {
    assert(variantId != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(FavouriteAPIs.removeFavorites),
        header: await API.header(),
        body: json.encoder.convert({'variant_id': variantId}),
      ),
    );
  }
}
