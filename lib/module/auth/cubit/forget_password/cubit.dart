import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/server/forget_password.dart';
import '../../repositories/auth_service.dart';
import 'states.dart';

class ForgetPasswordViewCubit extends Cubit<ForgetPasswordViewStates> {
  String email;

  bool showSendAgainButton = false;

  ForgetPasswordViewCubit() : super(InitialState());

  factory ForgetPasswordViewCubit.get(BuildContext context) =>
      BlocProvider.of<ForgetPasswordViewCubit>(context);

  Future<void> forgetPassword() async {
    await Future<void>.delayed(Duration.zero);
    emit(LoadingState());
    try {
      final Object result = await AuthService.forgetPassword(email: email);
      if (result is String) {
        throw result;
      }
      if (result is ForgetPassword) {
        showSendAgainButton = true;
        emit(MessageSendState(model: result));
      }
    } catch (e) {
      emit(IneffectiveErrorState(e: e.toString()));
    }
  }

  Future<void> sendAgain() async {
    showSendAgainButton = false;
    await forgetPassword();
    showSendAgainButton = false;
  }

  Future<void> onEmailChanged(String value) async {
    showSendAgainButton = false;
    await Future<void>.delayed(Duration.zero);
    email = value;
    if (validEmail) {
      emit(ValidEmail());
    } else {
      emit(InvalidEmail());
    }
  }

  bool get inValidEmail {
    return !validEmail;
  }

  bool get validEmail {
    return emailValidator(email) == null;
  }

  String emailValidator(String value) {
    email = value;

    if (email == null) {
      return 'invalid email';
    } else {
      if (EmailValidator.validate(email ?? '')) {
        return null;
      } else {
        return 'invalid email';
      }
    }
  }
}
