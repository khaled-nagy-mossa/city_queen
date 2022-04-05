import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CompanyDataNode extends StatelessWidget {
  final String svg;
  final String title;
  final VoidCallback onTap;
  final String toolTip;

  const CompanyDataNode({
    @required this.svg,
    @required this.title,
    @required this.onTap,
    this.toolTip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: toolTip ?? title,
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(svg, height: 30.0),
        title: Text(title??''),
      ),
    );
  }
}
