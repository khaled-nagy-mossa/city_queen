import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: const [
          Text('Loading'),
          SizedBox(width: 20.0),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
