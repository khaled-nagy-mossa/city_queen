import 'package:flutter/material.dart';

import 'const/app_data.dart';

// -----------------------------------------------------------------------------
// App Theme Class is helper class
// App Theme Class that contain Themes and control app style
// -----------------------------------------------------------------------------
abstract class AppTheme {
  static const int _primarySwatchValue = AppData.mainColorValue;
  static const MaterialColor primarySwatchMaterialColor = MaterialColor(
    _primarySwatchValue,
    <int, Color>{
      50: Color(_primarySwatchValue),
      100: Color(_primarySwatchValue),
      200: Color(_primarySwatchValue),
      300: Color(_primarySwatchValue),
      400: Color(_primarySwatchValue),
      500: Color(_primarySwatchValue),
      600: Color(_primarySwatchValue),
      700: Color(_primarySwatchValue),
      800: Color(_primarySwatchValue),
      900: Color(_primarySwatchValue),
    },
  );

  static ThemeData light() {
    return ThemeData(
      primarySwatch: primarySwatchMaterialColor,
      fontFamily: 'SF',
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      primaryTextTheme: const TextTheme(
        headline6: TextStyle(color: Colors.black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      tabBarTheme: const TabBarTheme(labelColor: Colors.black),
      platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    final temp = StringBuffer();
    temp.write(hexColor.toUpperCase().replaceAll('#', ''));
    if (hexColor.length == 6) {
      temp.write('FF${temp.toString()}');
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
