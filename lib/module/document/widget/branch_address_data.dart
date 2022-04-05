import 'package:app_launcher/app_launcher.dart';
import 'package:flutter/material.dart';

import '../../../common/assets/assets.dart';
import 'package:get/get.dart';
import '../model/contact_us.dart';
import 'company_data_node.dart';

class BranchAddressData extends StatelessWidget {
  final ContactUs contactUs;

  const BranchAddressData({@required this.contactUs})
      : assert(contactUs != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CompanyDataNode(
            toolTip: 'Location'.tr,
            svg: Assets.images.location,
            title: contactUs.address,
            onTap: () {
              AppLauncher.launchUrl(
                'https://www.google.com/maps/place/${contactUs.address}',
              );
            },
          ),
          const Divider(),
          CompanyDataNode(
            toolTip: 'State'.tr,
            svg: Assets.images.contact,
            title: contactUs.state,
            onTap: () {
              AppLauncher.launchUrl(
                'https://www.google.com/maps/place/${contactUs.state}',
              );
            },
          ),
          const Divider(),
          CompanyDataNode(
            toolTip: 'Country'.tr,
            svg: Assets.images.country,
            title: contactUs.country,
            onTap: () {
              AppLauncher.launchUrl(
                'https://www.google.com/maps/place/${contactUs.country}',
              );
            },
          ),
        ],
      ),
    );
  }
}
