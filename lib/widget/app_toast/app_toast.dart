import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

abstract class AppToast {
  const AppToast();

  static void normalToast({
    @required BuildContext context,
    @required String msg,
  }) {
    assert(context != null);
    assert(msg != null);

    Toast.show(msg, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
