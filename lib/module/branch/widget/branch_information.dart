import 'package:app_launcher/app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../model/branch.dart';
import 'package:get/get.dart';

class BranchInformation extends StatelessWidget {
  final Branch branch;

  const BranchInformation({@required this.branch});

  Future<void> _launchToPhone(BuildContext context, String phone) async {
    try {
      final errorMsg = await AppLauncher.launchToPhone(phone);

      if (errorMsg != null && errorMsg.isNotEmpty) {
        AppSnackBar.error(context, errorMsg);
      }
    } catch (e) {
      AppSnackBar.error(context, e.toString());
    }
  }

  Future<void> _launchToLocation(
    BuildContext context,
    String lat,
    String lng,
  ) async {
    try {
      final errorMsg = await AppLauncher.launchToMap(lat: lat, lon: lng);

      if (errorMsg != null && errorMsg.isNotEmpty) {
        AppSnackBar.error(context, errorMsg);
      }
    } catch (e) {
      AppSnackBar.error(context, e.toString());
    }
  }

  Future<void> _launchToEmail(BuildContext context, String email) async {
    try {
      final errorMsg = await AppLauncher.launchUrl('mailto:$email');

      if (errorMsg != null && errorMsg.isNotEmpty) {
        AppSnackBar.error(context, errorMsg);
      }
    } catch (e) {
      AppSnackBar.error(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 50.0),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _item(
                img: Assets.images.telephone,
                title: branch.phone,
                onTap: () => _launchToPhone(context, branch.phone),
              ),
              _item(
                img: Assets.images.location,
                title: branch.address,
                onTap: () => _launchToLocation(
                  context,
                  branch.lat,
                  branch.lng,
                ),
              ),
              _item(
                img: Assets.images.email,
                title: branch.email,
                onTap: () => _launchToEmail(context, branch.email),
              ),
              if (branch.topBranch)
                _item(
                  img: Assets.images.verified,
                  title: 'Top Branch'.tr,
                  useDivider: false,
                  onTap: () {},
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _item({
    @required String title,
    @required String img,
    @required VoidCallback onTap,
    bool useDivider = true,
  }) {
    if (title == null) return const SizedBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onTap,
          leading: SvgPicture.asset(img, height: 25.0),
          title: Text(title ?? ''),
        ),
        if (useDivider) const Divider(),
      ],
    );
  }
}
