import 'package:flutter/material.dart';

class LocationPermissionLocation extends StatelessWidget {
  final VoidCallback tryAgain;

  const LocationPermissionLocation({this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('application require permission.'),
      content: const Text(
        'we are sorry , application require permission to start live tracking and get orders',
      ),
      actions: [
        TextButton(
          onPressed: tryAgain,
          child: const Text('Try Again'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
