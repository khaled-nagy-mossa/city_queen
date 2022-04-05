import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_picker/place_picker.dart';

import '../../../../model/user/user_data.dart';
import '../../model/address_list.dart';
import '../../repositories/service.dart';
import 'cubit_extension.dart';
import 'states.dart';

class UserAddressesCubit extends Cubit<UserAddressesState> {
  AddressList addressList;

  UserAddressesCubit() : super(const InitialState()) {
    initial();
  }

  factory UserAddressesCubit.get(BuildContext context) {
    return BlocProvider.of<UserAddressesCubit>(context);
  }

  Future<void> initial() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await AddressesService.myAddresses();

      if (result is String) throw result;

      if (result is AddressList) {
        addressList = result;

        if (hasAddresses) {
          emit(const HasInitState());
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> addAddress({
    @required LocationResult location,
    @required UserData userData,
  }) async {
    assert(location != null);
    assert(userData != null);

    try {
      emit(const LoadingState());

      final Object result = await AddressesService.addAddresses(
        userData: userData,
        location: location,
      );

      if (result is String) throw result;

      if (result is AddressList) {
        addressList = result;

        if (hasAddresses) {
          emit(AddressAddedState(address: addressList.lines.last));
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<bool> updateOrderAddress({
    @required int addressId,
    @required int orderId,
    @required BuildContext context,
  }) async {
    assert(addressId != null);
    assert(orderId != null);
    try {
      emit(const LoadingState());

      // var result = await OrderService.updateOrderAddress(
      //     addressId: addressId, orderId: orderId);
      //
      // if (result is String) throw result;
      //
      // if (result is Order) {
      //   if (result.id == null) throw 'Unknown Exception : cart id = null';
      //
      //   String errorMsg =
      //       CartCubit.get(context).initial({'data': result.toMap()});
      //
      //   if (errorMsg == null) {
      //     emit(DataLoadedState(addressList: addressList));
      //     return true;
      //   } else {
      //     throw errorMsg;
      //   }
      // }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
    return false;
  }
}
