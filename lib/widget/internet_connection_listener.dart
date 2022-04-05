import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/material.dart';

class InternetConnectionListener extends StatelessWidget {
  final Widget widget;

  const InternetConnectionListener({@required this.widget});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        context,
        connectivity,
        child,
      ) {
        final connected = connectivity != ConnectivityResult.none;
        return Column(
          children: [
            if (!connected)
              Card(
                margin: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  decoration: const BoxDecoration(color: Colors.red),
                  child: const ListTile(
                    title: Text('No Internet Connection!',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            Expanded(child: widget),
          ],
        );
      },
      child: widget,
    );
  }
}
