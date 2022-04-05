library app_routes;

import 'package:flutter/material.dart';

/// app routes package makes it easy to navigate views
/// use package cause if flutter updated you don't need to update navigation code in all project
/// but update it here only
/// and use package cause if use need to save  all views direction
/// More methods have been added to make it easier to navigate without having to type in long code
/// say '7ayaty b2t a7san bikatir ana 7asyt fe3laan bialta8yir'
abstract class AppRoutes {
  const AppRoutes();

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  static Future<T?> pushWithDuration<T extends Object>({
    required BuildContext context,
    required Widget widget,
    required Duration duration,
  }) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: duration,
        pageBuilder: (_, __, ___) => widget,
      ),
    );
  }

  static Future<T?> push<T extends Object>(BuildContext context, Widget widget,
      {String? screenName}) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
        settings: RouteSettings(name: screenName),
      ),
    );
  }

  static Future<T?> pushNamed<T extends Object>(
      BuildContext context, String screenId,
      {Object? arguments}) async {
    Navigator.pushNamed(context, screenId, arguments: arguments);
  }

  static Future<void> pop<T extends Object>(BuildContext context,
      [Object? result]) async {
    if (canPop(context)) return Navigator.pop(context, result);
  }

  static Future<void> popUntil<T extends Object>(
      BuildContext context, String screenName) async {
    return Navigator.of(context).popUntil((route) {
      return route.settings.name == screenName;
    });
  }

  static Future<T?> pushAndRemoveUntil<T extends Object>(
      BuildContext context, Widget widget) async {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget),
        (route) => false);
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object>(
      BuildContext context, String screenId) async {
    return Navigator.pushNamedAndRemoveUntil(
        context, screenId, (route) => false);
  }

  static Future<T?> pushReplacement<T extends Object, TO extends Object>(
          BuildContext context, Widget widget) async =>
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => widget));

  static Future<T?> pushReplacementNamed<T extends Object, TO extends Object>(
          BuildContext context, String screenId) async =>
      Navigator.pushReplacementNamed(context, screenId);
}
