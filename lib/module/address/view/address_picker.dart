import 'package:place_picker/place_picker.dart';
import 'package:flutter/material.dart';
import '../../../common/config/map_config.dart';

//PlacePicker package for pick place and return LocationResult Object
class AddressPickerView extends StatelessWidget {
  static const String id = 'address_picker_view';

  const AddressPickerView();

  @override
  Widget build(BuildContext context) {
    return PlacePicker(MapConfig.key);
  }
}
