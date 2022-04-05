import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'pick_image.dart';

abstract class AppBottomSheet {
  const AppBottomSheet();

  static void pickImage({
    @required BuildContext context,
    @required void Function(ImageSource source) onSelect,
  }) {
    assert(context != null);
    assert(onSelect != null);
    showModalBottomSheet<PickImageBottomSheet>(
      context: context,
      builder: ( context) {
        return PickImageBottomSheet(onPicked: onSelect);
      },
    );
  }
}
