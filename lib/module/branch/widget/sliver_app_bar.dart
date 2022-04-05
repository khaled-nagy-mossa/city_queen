import 'package:app_routes/app_routes.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softgrow/module/product/model/helper/product_list_params.dart';
import 'package:softgrow/module/product/view/search.dart';

import '../../../common/config/api.dart';
import '../../global/view/image_view.dart';
import '../model/branch.dart';

class BranchSliverAppBar extends StatelessWidget {
  final Branch branch;

  const BranchSliverAppBar({@required this.branch}) : assert(branch != null);

  @override
  SliverAppBar build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        branch.name ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            AppRoutes.push(context,
                SearchView(params: ProductListParams(branchId: branch.id)));
          },
        ),
      ],
      pinned: true,
      floating: true,
      expandedHeight: 350.0,
      collapsedHeight: 90.0,
      shape: const _CustomShape(),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            _sliderGallery(context),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchToImageView(BuildContext context, String image) async =>
      AppRoutes.push(context, ImageView(image: NetworkImage(image)));

  Widget _sliderGallery(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(),
      child: Carousel(
        animationDuration: const Duration(seconds: 1),
        autoplayDuration: const Duration(seconds: 4),
        dotSize: 5.0,
        indicatorBgPadding: 7.0,
        dotBgColor: Colors.white.withOpacity(0.0),
        dotIncreasedColor: Colors.grey,
        images: <Widget>[
          GestureDetector(
            onTap: () {
              _launchToImageView(context, API.imageUrl(branch.image));
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(API.imageUrl(branch.image)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomShape extends ShapeBorder {
  const _CustomShape({
    this.side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
  })  : assert(side != null),
        assert(borderRadius != null);

  final BorderRadiusGeometry borderRadius;

  /// The style of this border.
  final BorderSide side;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return _CustomShape(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder lerpFrom(ShapeBorder a, double t) {
    assert(t != null);
    if (a is ContinuousRectangleBorder) {
      return ContinuousRectangleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder lerpTo(ShapeBorder b, double t) {
    assert(t != null);
    if (b is ContinuousRectangleBorder) {
      return ContinuousRectangleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    const length = 16;
    return Path()
      ..lineTo(0, rect.height - length)
      ..lineTo(rect.width, rect.height - length)
      ..lineTo(rect.width, 0)
      ..close();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    //its just a random number I came up with to test the border
    const length = 30.0;
    return Path()
      ..lineTo(0, rect.height)
      ..quadraticBezierTo(
          length / 4, rect.height - length, length, rect.height - length)
      ..lineTo(rect.width - length, rect.height - length)
      ..quadraticBezierTo(rect.width - (length / 4), rect.height - length,
          rect.width, rect.height)
      ..lineTo(rect.width, 0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final path = getOuterPath(rect, textDirection: textDirection);
        final paint = side.toPaint();

        canvas.drawPath(path, paint);
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is ContinuousRectangleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => hashValues(side, borderRadius);
}
