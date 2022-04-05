import 'package:flutter/material.dart';
import 'app_snack_bar.dart';

abstract class ExceptionsSnackBars {
  const ExceptionsSnackBars();

  static SnackBar normalException({@required String e}) {
    return SnackBar(content: Text(e));
  }

  static SnackBar unknownException() {
    return const SnackBar(content: Text('Unknown Exception'));
  }

  static SnackBar networkException() {
    return const SnackBar(content: Text('Network Exception'));
  }

  static SnackBar errorSnackBar({
    @required BuildContext context,
    @required String e,
  }) {
    return SnackBar(
      content: Text(e),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          AppSnackBar.hideSnackBar(context);
        },
      ),
    );
  }
}
