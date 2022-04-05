import 'package:flutter/material.dart';

abstract class AppData {
  const AppData();

  static const String appName = 'City Queen User';

  static const userRole = 'client';

  static const btnTextColor = Colors.white;

  static const mainColorValue = 0xFFCB1B5F;
  static const secondaryColorValue = 0xFFCB1B5F;

  static const mainColor = Color(mainColorValue);
  static const secondaryColor = Color(secondaryColorValue);

  static List<Color> get colorsList {
    return [mainColor, secondaryColor];
  }

  static Gradient get gradient {
    return LinearGradient(colors: colorsList);
  }

  static Gradient get customGradient {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colorsList,
    );
  }
}
