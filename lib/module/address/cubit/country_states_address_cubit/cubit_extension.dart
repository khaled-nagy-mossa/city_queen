import 'cubit.dart';

extension CountryStatesAddressCubitExtension on CountryStatesAddressCubit{
  bool get hasFilteredData {
    if (filteredData == null ||
        filteredData.items == null ||
        filteredData.items.isEmpty) {
      return false;
    }
    return true;
  }

  bool get hasCountries {
    if (stateList == null ||
        stateList.items == null ||
        stateList.items.isEmpty) {
      return false;
    }
    return true;
  }

}