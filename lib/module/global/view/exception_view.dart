import 'package:flutter/material.dart';

import '../../../widget/app_bar/default_app_bar.dart';
import '../widget/exception.dart';

class ExceptionView extends StatelessWidget {
  final String exceptionMsg;
  final String title;
  final RefreshCallback onRefresh;
  final bool showHomeButton;
  final String imagePath;
  final Size size;

  const ExceptionView({
    @required this.exceptionMsg,
    this.title = 'An Error Has Occurred',
    this.onRefresh,
    this.showHomeButton = false,
    this.imagePath,
    this.size,
  }) : assert(exceptionMsg != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: Text(title)),
      body: ExceptionWidget(
        exceptionMsg: exceptionMsg,
        imagePath: imagePath,
        size: size,
        onRefresh: onRefresh,
        showHomeButton: showHomeButton,
      ),
    );
  }
}
