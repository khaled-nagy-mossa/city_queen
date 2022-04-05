import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/state_list.dart';
import '../../repositories/service.dart';
import 'cubit_extension.dart';
import 'state.dart';

class CountryStatesAddressCubit extends Cubit<CountryStatesAddressStates> {
  StateList stateList = const StateList(items: []);
  StateList filteredData = const StateList(items: []);

  CountryStatesAddressCubit() : super(const InitialState());

  factory CountryStatesAddressCubit.get(BuildContext context) {
    return BlocProvider.of<CountryStatesAddressCubit>(context);
  }

  Future<void> initial(int id) async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await AddressesService.states(id);

      if (result is String) throw result;

      if (result is StateList) {
        stateList = result;
        filteredData = StateList(items: [...stateList.items]);

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
      for (var index = 0; index < stateList.items.length; index++) {
        final indexData = stateList.items[index].name;
        if (indexData.toLowerCase().startsWith(value.toLowerCase())) {
          filteredData.items.add(stateList.items[index]);
          emit(const FilterChangedState());
        }
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
