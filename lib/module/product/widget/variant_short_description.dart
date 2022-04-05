import 'package:flutter/material.dart';

import '../model/variant.dart';

class VariantShortDescription extends StatelessWidget {
  final Variant variant;

  final BoxShadow boxShadow;
  final RoundedRectangleBorder border;

  const VariantShortDescription({
    @required this.variant,
    this.boxShadow,
    this.border,
  }) : assert(variant != null);

  RoundedRectangleBorder get _border =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));

  @override
  Widget build(BuildContext context) {
    if (variant.shortDescription != null &&
        variant.shortDescription.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [boxShadow],
        ),
        child: Card(
          elevation: 0.0,

          shape: border ?? _border,
          margin: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Text(
              variant.shortDescription ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

// import 'package:softgrow/module/product/model/variant.dart';
// import 'package:flutter/material.dart';
//
// class VariantShortDescription extends StatelessWidget {
//   final Variant variant;
//
//   final double elevation;
//   final RoundedRectangleBorder border;
//
//   const VariantShortDescription({
//     @required this.variant,
//     this.elevation = 3.0,
//     this.border,
//   }) : assert(variant != null);
//
//   RoundedRectangleBorder get _border =>
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
//
//   @override
//   Widget build(BuildContext context) {
//     if (variant.shortDescription != null &&
//         variant.shortDescription.isNotEmpty) {
//       return Card(
//         elevation: elevation ?? 1.0,
//         shape: border ?? _border,
//         margin: EdgeInsets.zero,
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//           constraints: const BoxConstraints(
//             minWidth: double.infinity,
//           ),
//           child: Text(
//             variant.shortDescription ?? '',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }
