import 'dart:async';
import 'dart:convert';

import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class AddressesRepo {
  const AddressesRepo();

  // {GET} #####################################################################

  // get all world countries
  // header : Content-Type application/json
  static Future<SuperResponseModel> getCountries() async {
    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(AddressAPIs.getCountries),
      header: await API.header(),
    ));
  }

  // get all States of Country id
  // header : Content-Type application/json
  static Future<SuperResponseModel> getStates(int countryId) async {
    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
        HttpHelper.url(AddressAPIs.getStates),
        header: await API.header(),
        body: json.encoder.convert({'country_id': countryId})));
  }

  // {Post} ####################################################################

  //to get all user addresses
  // header : Content-Type application/json / AUTHORIZATION Bearer Token
  // body => {}  [you must send  { } in body]
  static Future<SuperResponseModel> getAddress() async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(AddressAPIs.getAddress),
        header: await API.header(),
        body: json.encoder.convert(<String ,dynamic>{})));
  }

  //to add new address to user addresses list
  // header : Content-Type application/json / AUTHORIZATION Bearer Token
  // body => {}  [you must send  { } in body]
  static Future<SuperResponseModel> addAddress(
    Map<String, dynamic> data,
  ) async {
    return HttpHelper.simpleRequest(HttpHelper.post(
        HttpHelper.url(AddressAPIs.addAddress),
        header: await API.header(),
        body: json.encoder.convert(data)));
  }
}
