import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final String title;
  final String assetImage;
  final VoidCallback onTap;

  const DrawerItemWidget(this.title, this.assetImage, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        constraints: BoxConstraints.tight(const Size(20.0, 20.0)),
        child: Image.asset(assetImage),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
