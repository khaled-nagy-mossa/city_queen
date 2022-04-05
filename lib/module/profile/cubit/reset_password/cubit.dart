import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/change_password.dart';
import '../../repositories/service.dart';
import 'states.dart';

class ChangePasswordViewCubit extends Cubit<ChangePasswordViewStates> {
  ChangePasswordModel model;

  ChangePasswordViewCubit() : super(const InitialState()) {
    model = ChangePasswordModel();
  }

  factory ChangePasswordViewCubit.get(BuildContext context) {
    return BlocProvider.of<ChangePasswordViewCubit>(context);
  }

  Future<void> changePassword() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final result = await ProfileService.changePassword(data: model.toMap());

      if (result != null && result.isNotEmpty) throw result;

      emit(const PasswordChangedState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
