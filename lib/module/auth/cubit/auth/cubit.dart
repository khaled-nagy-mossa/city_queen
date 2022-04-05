import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/preferences/app_shared_preference.dart';
import '../../../../model/user/user.dart';
import '../../../../model/user/user_data.dart';
import '../../../profile/repositories/service.dart';
import 'states.dart';

class AuthCubit extends Cubit<AuthStates> {
  User user = const User();

  AuthCubit() : super(const InitialState()) {
    _init();
  }

  factory AuthCubit.get(BuildContext context) {
    return BlocProvider.of<AuthCubit>(context);
  }

  Future<void> _init() async {
    try {
      final userJsonData = await AppSharedPreference.userData.getUserData();

      if (userJsonData == null || userJsonData.isEmpty) {
        emit(const SignOutState());
        return;
      }

      final Object result = await ProfileService.profileDetails();

      if (result is UserData) {
        final user = User(
          token: userJsonData['token'] as String,
          data: result,
        );

        if (user.unusable) throw 'Unknown Exception ';

        this.user = user;
        emit(SignedState(this.user));
      } else {
        throw result.toString();
      }
    } catch (e) {
      await AppSharedPreference?.userData?.clearData();

      final oldToken = e.toString() == 'Not Authorized!\n';

      final error = oldToken
          ? 'You are logged out of this device because you are logged in with the same account on another device'
          : 'exception when load your account data : $e';

      emit(IneffectiveErrorState(error: error));
    }
  }

  Future<void> signIn(User user) async {
    try {
      if (user != null && user.usable) {
        this.user = user;
        await AppSharedPreference.userData.setUserData(user.toMap());
        emit(SignedState(user));
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await AppSharedPreference.userData.clearData();

      user = const User();

      emit(const SignOutState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
