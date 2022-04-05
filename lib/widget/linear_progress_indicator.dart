import 'package:flutter/material.dart';

class AppLinearIndicator extends StatelessWidget {
  const AppLinearIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      alignment: Alignment.bottomCenter,
      child: const LinearProgressIndicator(
        color: Colors.grey,
        minHeight: 7.0,
      ),
    );
  }
}
