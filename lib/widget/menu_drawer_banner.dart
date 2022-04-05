import 'package:flutter/material.dart';

class ECommerceBanner extends StatelessWidget {
  const ECommerceBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top + 150.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://png.pngtree.com/thumb_back/fh260/back_our/20190620/ourmid/pngtree-simple-polygon-corporate-banner-image_147141.jpg',
          ),
        ),
      ),
    );
  }
}
