import 'cubit.dart';

extension AccountCubitExtension on AccountCubit {
  bool get signed {
    return user != null && user.usable;
  }
}
