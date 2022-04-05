import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/country_list.dart';
import '../../repositories/service.dart';
import 'cubit_extension.dart';
import 'state.dart';

class CountryPickerViewCubit extends Cubit<CountryPickerViewStates> {
  CountryList countryList = const CountryList(); //contain all data
  CountryList filteredData = const CountryList(); //contain all filtered data

  CountryPickerViewCubit() : super(const InitialState());

  factory CountryPickerViewCubit.get(BuildContext context) {
    return BlocProvider.of<CountryPickerViewCubit>(context);
  }

  Future<void> initial() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await AddressesService.countries();

      if (result is String) throw result;

      if (result is CountryList) {
        countryList = result;
        filteredData = CountryList(items: [...countryList?.items ?? []]);

        if (hasFilteredData) {
          emit(const HasInitState());
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
      return;
    }
  }

  void search(String value) {
    filteredData = filteredData.copyWith(data: []);

    try {
      for (var index = 0; index < countryList.items.length; index++) {
        final indexData = countryList.items[index].name;
        if (indexData.toLowerCase().startsWith(value.toLowerCase())) {
          filteredData.items.add(countryList.items[index]);

          emit(const FilterChangedState());
        }
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
