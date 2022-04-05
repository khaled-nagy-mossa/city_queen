import 'dart:async';

import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';
import '../model/helper/branch_list_params.dart';

abstract class BranchRepo {
  const BranchRepo();

  // method to get branchList (top , all , near)
  // PARAMS : limit5 offset0
  // params => branchesList?limit=5&offset=0&top_branch=true
  // header : Content-Type application/json
  // code 500 internal error
  static Future<SuperResponseModel> branchList({
    BranchListParams params,
  }) async {
    var url = BranchAPIs.branchList;

    if (params != null) {
      url += params.parse;
    }

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }

  // method to get branch by id
  // PARAMS : getBranch?branch_id=1
  // header : Content-Type application/json
  // Code 400 bad request (missing fields)
  // code 500 internal error
  static Future<SuperResponseModel> getBranch(int id) async {
    assert(id != null && id > 0);

    final url = '${BranchAPIs.getBranch}?branch_id=$id';

    return HttpHelper.simpleRequest(HttpHelper.getWithBodyData(
      HttpHelper.url(url),
      header: await API.header(),
    ));
  }
}
