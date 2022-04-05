import 'package:flutter/cupertino.dart';

abstract class SplashScreenStates {
  const SplashScreenStates();
}

class InitialState extends SplashScreenStates {
  const InitialState() : super();
}

class HasInitState extends SplashScreenStates {
  const HasInitState();
}
class LoadingState extends SplashScreenStates {
  const LoadingState();
}

class NoInternetState extends SplashScreenStates {
  const NoInternetState();
}

class IneffectiveErrorState extends SplashScreenStates {
  final String error;

  const IneffectiveErrorState({@required this.error});
}

class ExceptionState extends SplashScreenStates {
  final String error;

  const ExceptionState({@required this.error});
}
