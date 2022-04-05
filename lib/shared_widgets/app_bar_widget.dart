import 'package:flutter/material.dart';
import 'package:softgrow/util/style.dart';

class AppBarWidget {
  Widget showAppBar(BuildContext context, String title, bool home,
      GlobalKey<ScaffoldState> scaffoldKey) {
    return AppBar(
      backgroundColor: thirdColor,
      title: Image.asset(
        "images/logo3.png",
        width: 91,
        height: 31,
      ),
      centerTitle: true,
      actions: const <Widget>[],
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: wightColor,
        ),
        onPressed: () {
          scaffoldKey.currentState.openDrawer();
        },
      ),
      elevation: 10,
    );
  }
}
