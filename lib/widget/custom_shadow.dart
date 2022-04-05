import 'package:flutter/material.dart';

class CustomShadow extends StatelessWidget {
  final Widget child;

  const CustomShadow({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.1,
            blurRadius: 7,
          ),
        ],
      ),
      child: child,
    );
  }
}
