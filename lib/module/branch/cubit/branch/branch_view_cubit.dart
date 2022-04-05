import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'branch_view_states.dart';

class BranchViewCubit extends Cubit<BranchViewStates> {
  int currentOffset = 0, _currentPageViewIndex = 0;

  BranchViewCubit() : super(const InitialState());

  factory BranchViewCubit.get(BuildContext context) {
    return BlocProvider.of<BranchViewCubit>(context);
  }

  int get currentPageViewIndex {
    return _currentPageViewIndex;
  }

  set currentPageViewIndex(int index) {
    _currentPageViewIndex = index;
    if (index == 0) {
      emit(const PageViewChanged1State());
    } else {
      emit(const PageViewChanged2State());
    }
  }
}
