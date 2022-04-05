
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/home_view.dart';
import '../repositories/service.dart';
import 'states.dart';

class HomeViewCubit extends Cubit<HomeViewStates> {
  List<HomeViewModel> homeItems = <HomeViewModel>[];

  HomeViewCubit() : super(const InitialState()) {
    initial();
  }

  factory HomeViewCubit.get(BuildContext context) {
    return BlocProvider.of<HomeViewCubit>(context);
  }

  Future<void> initial() async {
    try {
      await Future<void>.delayed(Duration.zero);

      // final latLng = await _getLatLng();

      final Object result = await HomeViewService.homePage(null);

      if (result is String) throw result;

      if (result is List<HomeViewModel>) {
        homeItems = result;

        emit(const HasInitState());
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

// Future<LatLng> _getLatLng() async {
//   try {
//     if (await AppPermissions.isGrantedLocation()) {
//       return GoogleMapHelper.currentLocation();
//     }
//     return null;
//   } catch (e) {
//     log('Exception in HomeViewCubit._getLatLng : $e');
//     return null;
//   }
// }
}
