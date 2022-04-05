import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../module/auth/view/registration.dart';

class MustSignDialog extends StatelessWidget {
  const MustSignDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Access Denied!'),
      content: const Text('You must login before do that'),
      actions: [
        TextButton(
          onPressed: () async {
            await AppRoutes.pop(context);
            await AppRoutes.push(context, const RegistrationView());
          },
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
