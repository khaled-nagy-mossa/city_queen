
import '../../../../model/user/user_data.dart';

import 'cubit.dart';

extension AuthCubitExtension on AuthCubit {
  bool get signed {
    return user != null && user.usable;
  }

  UserData get userData => user?.data;
}
