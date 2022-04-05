import 'package:flutter/material.dart';

import '../../../common/assets/assets.dart';
import '../../global/view/empty_view.dart';

class EmptyConversationsWidget extends StatelessWidget {
  final RefreshCallback onRefresh;

  const EmptyConversationsWidget({this.onRefresh, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyView(
      title: 'No Conversations Found!',
      svgPath: Assets.images.chat,
      onRefresh: () async {
        if (onRefresh != null) await onRefresh();
      },
    );
  }
}
