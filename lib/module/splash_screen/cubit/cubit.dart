import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class SplashScreenCubit extends Cubit<SplashScreenStates> {
  SplashScreenCubit(BuildContext context) : super(const InitialState()) {
    init(context);
  }

  factory SplashScreenCubit.get(BuildContext context) {
    return BlocProvider.of<SplashScreenCubit>(context);
  }

  Future<void> init(BuildContext context) async {
    try {
      await Future<void>.delayed(Duration.zero); //more safety

      if (!await checkInternetConnection()) {
        emit(const NoInternetState());
        return;
      }
      emit(const HasInitState());
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> refresh(BuildContext context) async {
    emit(const LoadingState());

    await init(context);
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
