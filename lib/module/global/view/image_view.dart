// import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final ImageProvider image;
  final String heroTag;

  const ImageView({@required this.image, this.heroTag = ''})
      : assert(image != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: heroTag,
        child : Text('')
        // child: PhotoView(imageProvider: image),
      ),
    );
  }
}
