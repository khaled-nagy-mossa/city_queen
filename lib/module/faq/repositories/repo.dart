import 'dart:developer';

import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class FaqRepo {
  const FaqRepo();

  // method to get variant by product id and attributes id
  // PARAMS : getVariantByAttrUrl?product_id=5
  // header : Content-Type application/json
  static Future<SuperResponseModel> getFaq({int offset, int limit = 10}) async {
    var url = FaqAPIs.getFaq;

    if (_canUsePagination(offset, limit)) {
      url += '?limit=$limit&offset=${offset * 10}';
    }

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
        HttpHelper.url(url),
        header: await API.header()));
  }

  static bool _canUsePagination(int offset, int limit) {
    try {
      if (offset != null && limit != null && offset >= 0 && limit > 0) {
        return true;
      }
      return false;
    } catch (e) {
      log('Exception in FaqRepo._canUsePagination : $e');
      return false;
    }
  }
}
