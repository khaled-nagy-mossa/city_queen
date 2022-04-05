import 'package:app_routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';
import '../cubit/auth/cubit.dart';
import '../cubit/auth/states.dart';
import '../widget/auth_background.dart';
import '../widget/need_account.dart';
import 'sign_in.dart';

class RegistrationView extends StatelessWidget {
  static const String id = 'registration_view';

  const RegistrationView({Key key}) : super(key: key);

  static const SizedBox _itemPadding = SizedBox(height: 15.0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: AuthBackground(
            child: Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _itemPadding,
                  _itemPadding,
                  Text(
                    'Welcome'.tr,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  _itemPadding,
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  _itemPadding,
                  ElevatedButton(
                    onPressed: () {
                      AppRoutes.push(context, SignInView());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150.0, 40.0),
                    ),
                    child: Text('Login'.tr),
                  ).toGradient(context),
                  _itemPadding,
                  const NeedAccountWidget(navigateReplacement: false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
