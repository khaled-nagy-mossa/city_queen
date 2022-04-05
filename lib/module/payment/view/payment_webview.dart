import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../../auth/auth_observer/auth_builder.dart';
import 'package:get/get.dart';

class PaymentWebView extends StatefulWidget {
  static const String id = 'payment_web_view';

  final String url;
  final String successUrl;
  final VoidCallback onFinish;

  const PaymentWebView({
    @required this.url,
    @required this.successUrl,
    @required this.onFinish,
  })  : assert(url != null),
        assert(successUrl != null),
        assert(onFinish != null);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<String> _onUrlChanged;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return AuthListener(
        child: Scaffold(
          appBar: AppBar(title: Text('Payment View'.tr)),
          body: WebviewScaffold(url: widget.url),
        ),
      );
    } catch (e) {
      log('Exception in PaymentWebView : $e'.tr);
      return const Scaffold();
    }
  }
}
// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// import '../../auth/auth_observer/auth_builder.dart';
// import '../../localization/controller/app_localizations.dart';
//
// class PaymentWebView extends StatefulWidget {
//   static const String id = 'payment_web_view';
//
//   final String url;
//   final String successUrl;
//   final VoidCallback onFinish;
//
//   const PaymentWebView({
//     @required this.url,
//     @required this.successUrl,
//     @required this.onFinish,
//   })  : assert(url != null),
//         assert(successUrl != null),
//         assert(onFinish != null);
//
//   @override
//   _PaymentWebViewState createState() => _PaymentWebViewState();
// }
//
// class _PaymentWebViewState extends State<PaymentWebView> {
//   final _flutterWebViewPlugin = FlutterWebviewPlugin();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   StreamSubscription<String> _onUrlChanged;
//
//   StreamSubscription<String> _pageUrlListener() {
//     return _flutterWebViewPlugin.onUrlChanged.listen((url) {
//       log('url : $url'.tr;
//       if (mounted) {
//         if (url.startsWith(widget.successUrl)) {
//           widget.onFinish();
//         }
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     log('url : ${widget.url}'.tr;
//     _onUrlChanged = _pageUrlListener();
//   }
//
//   @override
//   void dispose() {
//     _onUrlChanged.cancel();
//     _flutterWebViewPlugin.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     try {
//       return AuthListener(
//         child: Scaffold(
//           appBar: AppBar(title: Text('Payment View'.tr)),
//           body: Container(
//             constraints: const BoxConstraints(),
//             child: WebviewScaffold(
//               key: _scaffoldKey,
//               url: widget.url,
//               withJavascript: true,
//               hidden: true,
//             ),
//           ),
//         ),
//       );
//     } catch (e) {
//       log('Exception in PaymentWebView : $e'.tr;
//       return const Scaffold();
//     }
//   }
// }
