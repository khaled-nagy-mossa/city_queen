import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../../global/view/image_view.dart';
import '../cubit/account/cubit.dart';
import '../cubit/account/cubit_extension.dart';
import 'pick_profile_image_btn.dart';

class ImageProfileView extends StatelessWidget {
  final VoidCallback onChangeImage;

  const ImageProfileView({@required this.onChangeImage});

  static const double _size = 180.0;

  @override
  Widget build(BuildContext context) {
    try {
      final cubit = AccountCubit.get(context);
      final networkImg = NetworkImage(API?.imageUrl(cubit?.user?.data?.avatar));

      return Container(
        constraints: BoxConstraints.tight(const Size(_size, _size)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.2,
              blurRadius: 7,
            ),
          ],
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                AppRoutes.push(context, ImageView(image: networkImg));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.cover, image: networkImg),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: PickProfileImageButton(
                onPickedImage: (file) async {
                  if (cubit?.signed == true) {
                    await cubit?.changeProfileAvatar(file);
                    if (onChangeImage != null) onChangeImage();
                  }
                },
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      log('Exception in ImageProfileView : $e');
      return const SizedBox();
    }
  }
}
