import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/loading_widget.dart';
import 'cubit/auth/cubit.dart';
import 'cubit/auth/states.dart';
import 'view/registration.dart';

class AuthBlocConsumer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;
  final bool allowUnauthorizedAccess;

  const AuthBlocConsumer({
    @required this.navigatorKey,
    @required this.child,
    this.allowUnauthorizedAccess = true,
  })  : assert(navigatorKey != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            if (state is InitialState) {
              return const LoadingWidget(color: Colors.white);
            } else {
              if (allowUnauthorizedAccess != true) return child;

              if (state is SignOutState) {
                return const RegistrationView();
              } else {
                return child;
              }
            }
          },
        );
      },
    );
  }
}
