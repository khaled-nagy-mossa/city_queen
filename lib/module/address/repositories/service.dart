import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';

import '../../../model/user/user_data.dart';
import '../model/address_list.dart';
import '../model/country_list.dart';
import '../model/state_list.dart';
import 'repo.dart';

abstract class AddressesService {
  const AddressesService();

  static Future countries() async {
    try {
      final res = await AddressesRepo.getCountries();

      if (res.hasError) throw res.msg;

      return CountryList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in AddressesService.countries : $e');
      return e.toString();
    }
  }

  static Future states(int countryId) async {
    assert(countryId != null);

    try {
      final res = await AddressesRepo.getStates(countryId);

      if (res.hasError) throw res.msg;

      return StateList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in AddressesService.states : $e');
      return e.toString();
    }
  }

  static Future myAddresses() async {
    try {
      final res = await AddressesRepo.getAddress();

      if (res.hasError) throw res.msg;

      return AddressList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in AddressesService.myAddresses : $e');
      return e.toString();
    }
  }

  static Future addAddresses({
    @required UserData userData,
    @required LocationResult location,
  }) async {
    try {
      final data = <String, dynamic>{
        'name': userData.name,
        'email': userData.email,
        'phone': userData.phone,
        'address': location.formattedAddress,
        'city': location.city?.name,
        'country_id': 65,
        'state_id': 278,
        'lat': location?.latLng?.latitude,
        'lng': location?.latLng?.longitude,
      };
      final res = await AddressesRepo.addAddress(data);
      if (res.hasError) return res.msg;

      return AddressList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in addAddresses in AddressService : $e');
      return e.toString();
    }
  }
}
