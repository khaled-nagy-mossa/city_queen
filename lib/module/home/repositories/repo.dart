import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class HomeViewRepo {
  const HomeViewRepo();

  static String _homePageEndPoint(LatLng latLng) {
    var url = HomeAPIs.homePage;

    if (latLng != null) {
      url += '?lat=${latLng?.latitude}&lng=${latLng?.longitude}';
    }

    return url;
  }

  // get all home page data
  // header : Content-Type application/json
  static Future<SuperResponseModel> homePage(LatLng latLng) async {
    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(_homePageEndPoint(latLng)),
      header: await API.header(),
    ));
  }
}
