import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../home/view/home.dart';

class ExceptionWidget extends StatelessWidget {
  final String exceptionMsg;

  final RefreshCallback onRefresh;
  final bool showHomeButton;
  final String imagePath;
  final Size size;

  const ExceptionWidget({
    @required this.exceptionMsg,
    this.onRefresh,
    this.showHomeButton = true,
    this.imagePath,
    this.size,
  }) : assert(exceptionMsg != null);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh();
      },
      child: Stack(
        children: <Widget>[
          ListView(),
          Container(color: Colors.white),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: (size?.width ?? 500.0) / 10,
            ),
            constraints: BoxConstraints.tight(
              size ?? const Size(double.infinity, double.infinity),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(flex: 5, child: Container()),
                Image.asset(imagePath ?? Assets.images.exception,
                    width: size?.width),
                Expanded(child: Container()),
                FittedBox(
                  child: Text(
                    exceptionMsg,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Expanded(flex: 15, child: Container()),
                if (showHomeButton == true)
                  ElevatedButton(
                    onPressed: () {
                      AppRoutes.pushAndRemoveUntil(context, const HomeView());
                    },
                    child: const Text('Go To Home'),
                  ).toGradient(context),
                Expanded(flex: 10, child: Container()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
