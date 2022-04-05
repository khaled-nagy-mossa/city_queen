import 'package:flutter/material.dart';

abstract class BranchViewStates {
  const BranchViewStates();
}

class InitialState extends BranchViewStates {
  const InitialState() : super();
}

class PageViewChanged1State extends BranchViewStates {
  const PageViewChanged1State() : super();
}

class PageViewChanged2State extends BranchViewStates {
  const PageViewChanged2State() : super();
}

class IneffectiveErrorState extends BranchViewStates {
  final String error;

  const IneffectiveErrorState({@required this.error}) : super();
}

class ExceptionState extends BranchViewStates {
  final String error;

  const ExceptionState({@required this.error}) : super();
}
