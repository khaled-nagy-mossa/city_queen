import 'cubit.dart';

extension CheckOrderViewCubitExtension on CheckOrderViewCubit {
  bool get hasData {
    if (order == null) {
      return false;
    }
    return true;
  }
}
