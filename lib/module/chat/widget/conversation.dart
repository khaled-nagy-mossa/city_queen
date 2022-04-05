import 'package:flutter/material.dart';

import '../model/conversation.dart';
import '../repositories/service.dart';

class ConversationListTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationListTile({
    @required this.conversation,
    @required this.onTap,
    Key key,
  })  : assert(conversation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (conversation.unusable) return const SizedBox();
    final user = ChatService.getAnotherUser(
      users: conversation.users,
      user: conversation.users.first,
    );
    return ListTile(
      onTap: () {
        if (onTap != null) onTap();
      },
      leading: Container(
        constraints: const BoxConstraints(
          maxHeight: 55.0,
          maxWidth: 55.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(user.avatar),
          ),
        ),
      ),
      title: Text(user?.name),
      subtitle: Text(conversation?.finalMessage?.text ?? "Let's Keep in touch"),
      trailing: _trailing(context),
    );
  }

  Widget _trailing(BuildContext context) {
    if (conversation?.finalMessage?.userId != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ChatService.convertTimeStampToyHms(
              conversation?.finalMessage?.timestamp,
            ),
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            ChatService.convertTimeStampToyMd(
              conversation?.finalMessage?.timestamp,
            ),
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
