import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/service.dart';
import '../../../../model/user/user.dart';
import '../../../../model/user/user_data.dart';
import '../../../auth/cubit/auth/cubit.dart';
import '../../../auth/cubit/auth/states.dart' as auth_states;
import '../../model/edit_profile.dart';
import '../../repositories/service.dart';
import 'cubit_extension.dart';
import 'states.dart';

class AccountCubit extends Cubit<AccountStates> {
  User user = const User();
  AuthCubit authCubit;
  StreamSubscription _streamSubscription;

  AccountCubit({@required this.authCubit}) : super(const InitialState()) {
    _streamSubscription = authCubit.stream.listen((event) {
      if (event is auth_states.SignedState) {
        initFromObject(event.user);
      }
      if (event is auth_states.SignOutState) clearCache();
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  factory AccountCubit.get(BuildContext context) {
    return BlocProvider.of<AccountCubit>(context);
  }

  Future<void> initFromObject(User user) async {
    await Future<void>.delayed(Duration.zero);

    this.user = user;

    if (signed) {
      emit(UpdatedProfileDataState(user: user));
    }
  }

  Future<void> changeProfileAvatar(File file) async {
    try {
      if (file == null) return;

      await Future<void>.delayed(Duration.zero);

      emit(const UpdatingProfileDataState());

      final base64 = AppService.convertFileToBase64(file);

      if (base64 == null || base64.isEmpty) return;

      final Object result =
          await ProfileService.uploadAvatar(avatarAsBase64: base64);

      if (result is String) throw result;

      if (result is UserData && result.usable) {
        ///pass random number [?15165] to reload image and clear image cache
        await updateUserDataObject(result.copyWith(
          avatar: '${result.avatar}?${'${Random.secure().nextInt(500)}'}',
        ));
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> updateUserData(EditProfileModel model) async {
    try {
      await Future<void>.delayed(Duration.zero);

      emit(const UpdatingProfileDataState());

      final Object result = await ProfileService.editProfileData(model.toMap());

      if (result is String) throw result;

      if (result is UserData) await updateUserDataObject(result);
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> updateUserDataObject(UserData userData) async {
    try {
      await Future<void>.delayed(Duration.zero);

      user = user.copyWith(
        usermodel: user.data.copyWith(
          id: userData.id,
          email: userData.email,
          avatar: userData.avatar,
          phone: userData.phone,
          name: userData.name,
        ),
      );

      emit(UpdatedProfileDataState(user: user));
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> clearCache() async {
    await Future<void>.delayed(Duration.zero);
    user = const User();
    emit(UpdatedProfileDataState(user: user));
  }
}
