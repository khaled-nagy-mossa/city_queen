import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';
import '../cubit/chat/cubit.dart';
import '../model/message.dart';
import '../repositories/service.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({@required this.message, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message == null || message.unusable) {
      return const SizedBox();
    }

    final user = ChatCubit.get(context).chatUser;

    return Column(
      crossAxisAlignment: user.id != message.userId
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Bubble(
          color: user.id != message.userId ? AppData.mainColor : Colors.white,
          alignment: user.id != message.userId
              ? Alignment.centerLeft
              : Alignment.centerRight,
          borderUp: true,
          padding: const BubbleEdges.symmetric(horizontal: 14.0),
          shadowColor: Colors.blue,
          elevation: 1,
          nip: user.id == message.userId
              ? BubbleNip.rightTop
              : BubbleNip.leftTop,
          child: Text(
            message.text,
            style: TextStyle(
              color: user.id != message.userId ? Colors.white : null,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          child: Text(
            ChatService.convertTimeStampToyHms(message?.timestamp),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
