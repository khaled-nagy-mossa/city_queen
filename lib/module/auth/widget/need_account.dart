import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/sign_up.dart';

class NeedAccountWidget extends StatelessWidget {
  final bool navigateReplacement;

  const NeedAccountWidget({this.navigateReplacement = true, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'need an account?'.tr,
          style: Theme.of(context).textTheme.caption,
        ),
        TextButton(
          onPressed: () {
            if (navigateReplacement == true) {
              AppRoutes.pushReplacement(context, SignUpView());
            } else {
              AppRoutes.push(context, SignUpView());
            }
          },
          child: Text('Sign Up'.tr),
        ),
      ],
    );
  }
}
