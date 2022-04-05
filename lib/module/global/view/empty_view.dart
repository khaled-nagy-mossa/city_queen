import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String title, svgPath;
  final RefreshCallback onRefresh;

  const EmptyView({
    @required this.title,
    @required this.svgPath,
    @required this.onRefresh,
  })  : assert(title != null),
        assert(svgPath != null),
        assert(onRefresh != null);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: [
          ListView(),
          Container(
            padding: const EdgeInsets.all(50.0),
            color: Colors.white,
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                Expanded(flex: 15, child: Container()),
                SvgPicture.asset(svgPath, color: Colors.grey),
                Expanded(child: Container()),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .merge(const TextStyle(color: Colors.grey)),
                ),
                Expanded(flex: 10, child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
