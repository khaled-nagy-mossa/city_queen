import 'dart:developer';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../model/banner.dart';

class SliderBanner extends StatelessWidget {
  final SliderBannerModel bannerModel;

  const SliderBanner({@required this.bannerModel})
      : assert(bannerModel != null);

  List<NetworkImage> get _bannerItems {
    try {
      return bannerModel?.banners?.map((e) {
            return NetworkImage(API.imageUrl(e));
          })?.toList() ??
          [];
    } catch (e) {
      log('Exception in SliderBanner._bannerItems : $e');
      return <NetworkImage>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (bannerModel.unusable || bannerModel.banners.isEmpty) {
      return const SizedBox();
    }

    return Container(
      height: 200.0,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Carousel(
        images: _bannerItems,
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.grey,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.purple.withOpacity(0.5),
        // borderRadius: true,
      ),
    );
  }
}
