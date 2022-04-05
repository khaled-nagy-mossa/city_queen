import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import 'package:get/get.dart';

class NoInternetView extends StatelessWidget {
  final RefreshCallback onRefresh;

  const NoInternetView({@required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: Text('No Internet'.tr)),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Stack(
          children: <Widget>[
            ListView(),
            Container(
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(),
                    height: 350.0,
                    child: FlareActor(
                      Assets.flares.errorConnection,
                      animation: 'idle',
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'Internet Connection Error!'.tr,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: onRefresh,
                    child: Text('Try Again'.tr),
                  ).toGradient(context),
                  Expanded(child: Container()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
