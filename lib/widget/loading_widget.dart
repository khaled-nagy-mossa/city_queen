import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;

  const LoadingWidget({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: color ?? Colors.grey.withOpacity(0.5),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
