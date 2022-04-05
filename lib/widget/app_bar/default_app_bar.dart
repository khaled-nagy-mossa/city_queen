import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../../common/assets/assets.dart';
import '../../module/cart/widget/cart_icon.dart';
import '../../module/product/view/search.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.gradient,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  });

  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final ShapeBorder shape;
  final Gradient gradient;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: NewGradientAppBar(
            leading: leading ?? _defaultLeading(context),
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: title,
            actions: actions ?? _defaultActions(context),
            flexibleSpace: flexibleSpace,
            bottom: bottom,
            elevation: elevation,
            shape: shape,
            // gradient: gradient ?? AppData.gradient,
            brightness: brightness,
            iconTheme: iconTheme,
            textTheme: textTheme,
            primary: primary,
            centerTitle: centerTitle,
            titleSpacing: titleSpacing,
            toolbarOpacity: toolbarOpacity,
            bottomOpacity: bottomOpacity,
          ),
        ),
        // Container(
        //   constraints: const BoxConstraints(maxHeight: 50.0),
        //   child: const CurvedBottomAppbar(),
        // ),
      ],
    );
  }

  Widget _defaultLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(Assets.images.menu),
      ),
    );
  }

  List<Widget> _defaultActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          AppRoutes.push(context, SearchView());
        },
        icon: const Icon(Icons.search),
      ),
      const CartIcon(),
    ];
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize?.height ?? 0.0;
    const appBarCurvedHeight = 0.0;
    return Size.fromHeight(kToolbarHeight + appBarCurvedHeight + bottomHeight);
  }
}
