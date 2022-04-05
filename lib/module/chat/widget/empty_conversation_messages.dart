import 'package:flutter/material.dart';

import '../../../common/assets/assets.dart';
import '../../global/view/empty_view.dart';

class EmptyConversationMessagesWidget extends StatelessWidget {
  final RefreshCallback onRefresh;

  const EmptyConversationMessagesWidget({this.onRefresh, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyView(
      title: 'No Messages Found!',
      svgPath: Assets.images.chat,
      onRefresh: () async {
        if (onRefresh != null) await onRefresh();
      },
    );
  }
}
