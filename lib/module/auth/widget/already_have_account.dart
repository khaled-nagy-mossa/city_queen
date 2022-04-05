import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/sign_in.dart';

class AlreadyHaveAccount extends StatelessWidget {
  final bool navigateReplacement;

  const AlreadyHaveAccount({this.navigateReplacement = true, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'already have account?'.tr,
          style: Theme.of(context).textTheme.caption,
        ),
        TextButton(
          onPressed: () {
            if (navigateReplacement == true) {
              AppRoutes.pushReplacement(context, SignInView());
            } else {
              AppRoutes.push(context, SignInView());
            }
          },
          child: Text('Sign in'.tr),
        ),
      ],
    );
  }
}
