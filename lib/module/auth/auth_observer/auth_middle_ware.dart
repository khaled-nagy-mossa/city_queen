import 'package:flutter/material.dart';

import '../../../widget/app_dialog/app_dialog.dart';
import '../cubit/auth/cubit.dart';
import '../cubit/auth/cubit_extension.dart';

void authMiddleWare({
  @required BuildContext context,
  @required Function action,
}) {
  assert(context != null);
  assert(action != null);

  if (AuthCubit.get(context).signed) {
    action();
  } else {
    AppDialog.mustSign(context);
  }
}
