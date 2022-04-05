import 'cubit.dart';

extension UserAddressesCubitExtension on UserAddressesCubit{

  bool get hasAddresses {
    return addressList != null &&
        addressList.usable &&
        addressList.lines.isNotEmpty;
  }
}