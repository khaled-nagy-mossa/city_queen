import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';


import '../../../common/assets/assets.dart';
import '../../../common/const/app_data.dart';
import '../../../widget/app_bottom_sheet/app_bottom_sheet.dart';

class PickProfileImageButton extends StatelessWidget {
  final void Function(File file) onPickedImage;

  const PickProfileImageButton({@required this.onPickedImage})
      : assert(onPickedImage != null);

  static const _size = 40.0;

  void _onTap(BuildContext context) {
    AppBottomSheet.pickImage(
      context: context,
      onSelect: (imageSource) async {
        final pickedFile = await ImagePicker().getImage(
          source: imageSource,
          imageQuality: 25,
        );

        Navigator.pop(context); //to close bottom sheet

        if (pickedFile != null) {
          onPickedImage(File(pickedFile.path));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return GestureDetector(
        onTap: () {
          _onTap(context);
        },
        child: Container(
          padding: const EdgeInsets.all(7.0),
          constraints: BoxConstraints.tight(const Size(_size, _size)),
          decoration: BoxDecoration(
            gradient: AppData.gradient,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            Assets.images.camera,
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      log('Exception in PickProfileImageButton : $e');
      return const SizedBox();
    }
  }
}
