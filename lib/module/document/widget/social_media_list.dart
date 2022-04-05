import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:softgrow/common/assets/assets.dart';
import '../model/contact_us.dart';
import 'social_media.dart';

// ignore: must_be_immutable
class SocialMediaList extends StatelessWidget {
  final ContactUs contactUs;
  final void Function(String url) onTap;

  SocialMediaList({@required this.contactUs, @required this.onTap})
      : assert(contactUs != null),
        assert(onTap != null);

  List<Widget> _items = [];

  void _init() {
    _items = <Widget>[
      SocialMediaNode(
        toolTip: 'Website'.tr,
        svg: Assets.images.web,
        url: contactUs.website,
        onTap: onTap,
      ),
      SocialMediaNode(
        toolTip: 'Twitter'.tr,
        svg: Assets.images.twitter,
        url: contactUs.twitter,
        onTap: onTap,
      ),
      SocialMediaNode(
        toolTip: 'Facebook'.tr,
        svg: Assets.images.facebook,
        url: contactUs.facebook,
        onTap: onTap,
      ),
      SocialMediaNode(
        toolTip: 'LinkedIn'.tr,
        svg: Assets.images.linkedIn,
        url: contactUs.linkedin,
        onTap: onTap,
      ),
      SocialMediaNode(
        toolTip: 'Youtube'.tr,
        svg: Assets.images.youtube,
        url: contactUs.youtube,
        onTap: onTap,
      ),
      SocialMediaNode(
        toolTip: 'Instagram'.tr,
        svg: Assets.images.instagram,
        url: contactUs.instagram,
        onTap: onTap,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _init();
    if (_items.isEmpty) {
      return const SizedBox();
    }

    return Container(
      height: 50.0,
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: _items,
      ),
    );
  }
}
