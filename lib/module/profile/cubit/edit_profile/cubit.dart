import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/user/user_data.dart';
import '../../model/edit_profile.dart';

import 'states.dart';

class EditProfileViewCubit extends Cubit<EditProfileViewStates> {
  EditProfileModel model = const EditProfileModel();

  EditProfileViewCubit(UserData userData) : super(const InitialState()) {
    init(userData);
  }

  factory EditProfileViewCubit.get(BuildContext context) {
    return BlocProvider.of<EditProfileViewCubit>(context);
  }

  Future<void> init(UserData userData) async {
    model = EditProfileModel?.fromMap(userData?.toMap());
  }

  Future<void> changeName(String value) async {
    try {
      await Future<void>.delayed(Duration.zero);
      model = model.copyWith(name: value);
      emit(const NameChangedState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> changeEmail(String value) async {
    try {
      await Future<void>.delayed(Duration.zero);
      model = model.copyWith(email: value);
      emit(const EmailChangedState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> changePhone(String value) async {
    try {
      await Future<void>.delayed(Duration.zero);
      model = model.copyWith(phone: value);
      emit(const PhoneChangedState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
