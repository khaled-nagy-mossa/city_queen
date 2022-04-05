import '../../model/branches_list.dart';
import 'branches_cubit.dart';

extension BranchesCubitExtension on BranchesViewCubit {
  void initialFromObject(BranchList initData) {
    if (initData == null) return;

    branchList = BranchList(
      count: initData.count,
      branches: initData.branches,
    );
  }

  bool get isEmpty {
    return branchList.unusable ||
        branchList.count == 0 ||
        branchList.branches.isEmpty;
  }

  void increaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? -10) + 10);
  }

  void decreaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? 10) - 10);
  }

  void resetOffset() {
    params = params.copyWith(offset: 0);
  }
}
