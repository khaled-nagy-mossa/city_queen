
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth/cubit.dart';
import '../cubit/auth/cubit_extension.dart';
import '../cubit/auth/states.dart';
import '../view/registration.dart';

class AuthListener extends StatelessWidget {
  final Widget child;

  const AuthListener({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AuthCubit?.get(context)?.signed == true) {
          return child;
        } else {
          return const RegistrationView();
        }
      },
    );
  }
}
