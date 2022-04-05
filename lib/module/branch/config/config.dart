import '../../../common/config/api.dart';

abstract class BranchAPIs {
  const BranchAPIs();

  //to get all Branches
  //type get
  //params => branchesList?limit=5&offset=0&top_branch=true
  //params => branchesList?limit=5&offset=0&lat=29.9973063&lng=31.3108363
  static String branchList = '${API.baseUrl}/branch_list',
      //to get Branch With Id
      //type get
      //params => getBranch?branch_id=1
      getBranch = '${API.baseUrl}/get_branch';
}
