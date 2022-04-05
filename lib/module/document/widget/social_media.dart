import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SocialMediaNode extends StatelessWidget {
  final String svg;
  final String url;
  final String toolTip;
  final void Function(String url) onTap;

  const SocialMediaNode({
    @required this.onTap,
    @required this.svg,
    @required this.url,
    this.toolTip,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null || url.isEmpty) return const SizedBox();
    return Tooltip(
      message: toolTip ?? 'Social Media'.tr,
      child: GestureDetector(
        onTap: () => onTap(url),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SvgPicture.asset(svg, height: 30.0),
        ),
      ),
    );
  }
}
