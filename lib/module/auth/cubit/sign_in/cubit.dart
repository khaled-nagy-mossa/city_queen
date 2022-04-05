import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/user/user.dart';
import '../../model/sign_in.dart';
import '../../repositories/auth_service.dart';
import 'states.dart';

class SignInViewCubit extends Cubit<SignInViewStates> {
  final SignInModel model = SignInModel();
  bool notVisiblePassword = true;

  SignInViewCubit() : super(InitialState());

  factory SignInViewCubit.get(BuildContext context) =>
      BlocProvider.of<SignInViewCubit>(context);

  Future login(GlobalKey<FormState> formKey) async {
    await Future<void>.delayed(Duration.zero);
    try {
      if (formKey.currentState.validate()) {
        emit(LoadingState());
        final Object result = await AuthService.signIn(data: model.toMap());

        if (result is String) throw result;

        if (result is User) return result;
      } else {
        emit(IneffectiveErrorState(e: 'The login information is invalid!'));
      }
    } catch (e) {
      emit(IneffectiveErrorState(e: e.toString()));
    }
  }

  void get changePasswordVisibility {
    notVisiblePassword = !notVisiblePassword;
    emit(VisiblePasswordState(vp: notVisiblePassword));
  }

  Future<void> onEmailChanged(String value) async {
    await Future<void>.delayed(Duration.zero);
    model.email = value;
    if (model.validEmail) {
      emit(ValidEmail());
    } else {
      emit(InvalidEmail());
    }
  }

  Future<void> onPasswordChanged(String value) async {
    await Future<void>.delayed(Duration.zero);
    model.password = value;

    if (model.validPassword) {
      emit(ValidPassword());
    } else {
      emit(InvalidPassword());
    }
  }
}
