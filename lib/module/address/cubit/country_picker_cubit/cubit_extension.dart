import 'cubit.dart';

extension CountryPickerViewCubitExtension on CountryPickerViewCubit{
  bool get hasFilteredData {
    return filteredData != null &&
        filteredData.usable &&
        filteredData.items.isNotEmpty;
  }

  bool get hasCountries {
    return countryList != null &&
        countryList.usable &&
        countryList.items.isNotEmpty;
  }
}