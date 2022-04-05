import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/branches_list.dart';
import '../../model/helper/branch_list_params.dart';
import '../../repositories/branch_service.dart';
import 'branches_cubit_extension.dart';
import 'branches_states.dart';

class BranchesViewCubit extends Cubit<BranchesViewStates> {
  BranchList branchList = const BranchList();
  BranchListParams params;

  BranchesViewCubit({
    BranchList initData,
    this.params = const BranchListParams(offset: 0),
  }) : super(const InitialState()) {
    initialFromObject(initData);
    init();
  }

  factory BranchesViewCubit.get(BuildContext context) {
    return BlocProvider.of<BranchesViewCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await BranchService.branchList(params: params);

      if (result is String) throw result;

      if (result is BranchList) {
        if (result.unusable) throw 'Unknown Exception';
        branchList = result;
      }

      if (isEmpty) {
        emit(const EmptyState());
      } else {
        emit(const HasInitState());
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> fetchMore() async {
    if (state is FetchingDataState) return;

    ///use >= operator to more safety [Currently the server returns data if you send an offset : 1,000 and limit : 10,000 ] even if there are only 32 products
    if (branchList.branches.length >= branchList.count) {
      return;
    }

    try {
      emit(const FetchingDataState());

      increaseOffset();

      final Object result = await BranchService.branchList(params: params);

      if (result is String) throw result;

      if (result is BranchList) {
        branchList?.branches?.addAll(result?.branches ?? []);
      }

      emit(const HasFetchedDataState());
    } catch (e) {
      decreaseOffset();
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      await Future<void>.delayed(Duration.zero);

      resetOffset();

      await init();
    } catch (e) {
      IneffectiveErrorState(error: e.toString());
    }
  }
}
