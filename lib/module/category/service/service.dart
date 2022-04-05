import 'dart:developer';

import 'package:flutter/material.dart';

abstract class CategoryHelper {
  const CategoryHelper();

  //this method calculate gridDelegate
  //if current size can container 3 node return 3 if can contain 4 return 4
  static SliverGridDelegate gridDelegate(BuildContext context) {
    try {
      final temp =
          ((MediaQuery.of(context).size.width / 100).ceil() / 2.0).floor();

      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: temp + 1,
        childAspectRatio: 0.9,
      );
    } catch (e) {
      log('Exception in CategoryHelper.gridDelegate : $e');
      return const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3);
    }
  }
}
