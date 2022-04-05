import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../common/const/app_data.dart';

class CurvedBottomAppbar extends StatelessWidget {
  const CurvedBottomAppbar();

  static const _heightRatio = 0.125;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return CustomPaint(
      size: Size(width, width * _heightRatio),
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height * 0.1960000),
        Offset(size.width, size.height * 0.1960000),
        AppData.colorsList,
      )
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    final path = Path();

    path.moveTo(0, size.height * 0.9800000);

    path.quadraticBezierTo(
      size.width * -0.0050000,
      size.height * 0.2475000,
      0,
      0,
    );

    path.quadraticBezierTo(
      size.width * 0.2453125,
      size.height * -0.0200000,
      size.width,
      size.height * -0.0200000,
    );

    path.lineTo(size.width, size.height);

    path.quadraticBezierTo(
      size.width * 0.9684375,
      size.height * 0.2125000,
      size.width * 0.8437500,
      size.height * 0.1900000,
    );

    path.cubicTo(
      size.width * 0.8440625,
      size.height * 0.1900000,
      size.width * 0.1587500,
      size.height * 0.2125000,
      size.width * 0.1575000,
      size.height * 0.2100000,
    );

    path.quadraticBezierTo(
      size.width * 0.0287500,
      size.height * 0.2450000,
      0,
      size.height * 0.9800000,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
