import 'package:flutter/material.dart';
import '../../../common/assets/assets.dart';

class AuthBackground extends StatelessWidget {
  static const String id = 'auth_background';
  final Widget child;

  const AuthBackground({@required this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'auth_background',
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.images.authCover),
              ),
            ),
          ),
        ),
        Hero(
          tag: 'child_of_auth_background',
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Card(
              elevation: 20,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 25.0),
                  Container(
                    height: 7.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.grey,
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
