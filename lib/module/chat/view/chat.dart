import 'package:app_routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/loading_widget.dart';
import '../../global/widget/exception.dart';
import '../cubit/chat/cubit.dart';
import '../cubit/chat/states.dart';
import '../model/conversation.dart';
import '../repositories/chat_repo.dart';
import '../view/conversation.dart';
import '../widget/conversation.dart';
import '../widget/empty_conversations.dart';

class ChatView extends StatelessWidget {
  static const id = 'chat_view';

  const ChatView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Chat')),
          body: Stack(
            children: [
              _body(context),
              if (state is LoadingState) const LoadingWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    final cubit = ChatCubit.get(context);
    if (cubit.unusable) {
      return const Center(child: Text('No User Found !'));
    }
    return StreamBuilder<QuerySnapshot>(
      stream: ChatRepo.conversationsOfUser(uid: cubit.chatUser.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return ExceptionWidget(
            onRefresh: () async {},
            exceptionMsg: snapshot.error.toString(),
          );
        } else {
          final length = snapshot?.data?.docs?.length ?? 0;

          if (length == 0) return const EmptyConversationsWidget();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            itemCount: length,
            itemBuilder: (context, index) {
              final conversation = Conversation.fromMap(
                snapshot?.data?.docs[index]?.data(),
              );
              if (conversation == null || conversation.unusable) {
                return const SizedBox();
              }

              return ConversationListTile(
                onTap: () {
                  AppRoutes.push(
                    context,
                    ConversationView(conversation: conversation),
                  );
                },
                conversation: conversation,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        }
      },
    );
  }
}
