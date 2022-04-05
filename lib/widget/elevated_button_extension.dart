// import 'dart:developer';

import 'package:flutter/material.dart';

// import '../common/const/app_data.dart';

extension ElevatedButtonExtension on ElevatedButton {
  // ///get the default button theme from theme data file
  // ElevatedButtonThemeData _btnDefaultTheme(BuildContext context) {
  //   try {
  //     return Theme?.of(context)?.elevatedButtonTheme;
  //   } catch (e) {
  //     log('Exception in ElevatedButtonExtension._btnDefaultTheme : $e');
  //     return const ElevatedButtonThemeData();
  //   }
  // }
  //
  // ///if style.shape == null ->
  // /// get the default button shape from the theme data file
  // OutlinedBorder _btnShape(BuildContext context) {
  //   try {
  //     return style?.shape?.resolve({}) ??
  //         _btnDefaultTheme(context)?.style?.shape?.resolve({});
  //   } catch (e) {
  //     log('Exception in ElevatedButtonExtension._btnShape : $e');
  //     return const RoundedRectangleBorder();
  //   }
  // }
  //
  // ///if style.elevation == null ->
  // /// get the default button elevation from the theme data file
  // double _btnElevation(BuildContext context) {
  //   try {
  //     return style?.elevation?.resolve({}) ??
  //         _btnDefaultTheme(context)?.style?.elevation?.resolve({});
  //   } catch (e) {
  //     log('Exception in ElevatedButtonExtension._btnElevation : $e');
  //     return 2.0;
  //   }
  // }
  //
  // ButtonStyle _btnStyle() {
  //   return style?.copyWith(
  //         backgroundColor: MaterialStateProperty.all<Color>(
  //           Colors.transparent,
  //         ),
  //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //         elevation: MaterialStateProperty.all<double>(0.0),
  //       ) ??
  //       ElevatedButton.styleFrom(
  //         primary: Colors.transparent,
  //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //         elevation: 0.0,
  //       );
  // }

  Widget toGradient(BuildContext context, {Gradient gradient}) {
    return this;
  }
// try {
//   return Card(
//     shape: _btnShape(context),
//     elevation: _btnElevation(context),
//     clipBehavior: Clip.antiAlias,
//     child: Container(
//       decoration: BoxDecoration(gradient: gradient ?? AppData.gradient),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: _btnStyle(),
//         child: child,
//       ),
//     ),
//   );
// } catch (e) {
//   log('Exception in ElevatedButtonExtension.toGradient : $e');
//   return this;
// }
// }
}
