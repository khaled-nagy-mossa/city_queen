import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/user/user.dart';
import '../../../address/model/country.dart';
import '../../../address/model/state.dart';
import '../../model/sign_up.dart';
import '../../repositories/auth_service.dart';
import 'states.dart';

class SignUpViewCubit extends Cubit<SignUpViewStates> {
  final SignUpModel model = SignUpModel();
  bool notVisiblePassword = true;
  bool notVisibleConfirmPassword = true;

  SignUpViewCubit() : super(InitialState());

  factory SignUpViewCubit.get(BuildContext context) =>
      BlocProvider.of<SignUpViewCubit>(context);

  Future<User> signUp(GlobalKey<FormState> formKey) async {
    await Future<void>.delayed(Duration.zero);
    try {
      if (formKey.currentState.validate()) {
        if (model.country == null) throw 'You muse Select Country First';
        if (model.state == null) throw 'You muse Select State First';

        emit(LoadingState());
        final Object result = await AuthService.signUp(data: model.toMap());

        if (result is String) throw result;
        if (result is User) return result;
      } else {
        emit(IneffectiveErrorState(e: 'sign up information is invalid!'));
      }
    } catch (e) {
      emit(IneffectiveErrorState(e: e.toString()));
    }
    return null;
  }

  void changeCountry(Country country) {
    if (country != null) {
      model.country = country;
      emit(CountryChangedState());
    }
  }

  void changeState(StateLocation state) {
    if (state != null) {
      model.state = state;
      emit(StateLocationChangedState());
    }
  }

  void get changePasswordVisibility {
    notVisiblePassword = !notVisiblePassword;
    emit(VisiblePasswordState(vp: notVisiblePassword));
  }

  void get changeConfirmPasswordVisibility {
    notVisibleConfirmPassword = !notVisibleConfirmPassword;
    emit(VisiblePasswordState(vp: notVisibleConfirmPassword));
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

  Future<void> onConfirmPasswordChanged(String value) async {
    await Future<void>.delayed(Duration.zero);
    model.confirmPassword = value;

    if (model.validConfirmPassword) {
      emit(ValidConfirmPassword());
    } else {
      emit(ValidConfirmPassword());
    }
  }
}
