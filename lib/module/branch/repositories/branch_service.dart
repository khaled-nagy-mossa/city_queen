import 'dart:async';
import 'dart:developer';

import '../model/branch.dart';
import '../model/branches_list.dart';
import '../model/helper/branch_list_params.dart';
import 'branch_repo.dart';

abstract class BranchService {
  const BranchService();

  static Future branchList({BranchListParams params}) async {
    try {
      final res = await BranchRepo.branchList(params: params);

      if (res.hasError) throw res.msg;

      return BranchList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in BranchService.branchList : $e');
      return e.toString();
    }
  }

  static Future branchById(int id) async {
    try {
      final res = await BranchRepo.getBranch(id);

      if (res.hasError) throw res.msg;

      return Branch.fromMap(
        res.json['result']['branch'] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in BranchService.branchById : $e');
      return e.toString();
    }
  }
}
