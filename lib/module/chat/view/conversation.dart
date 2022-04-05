import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide Flow;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/config/api.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/cubit/auth/cubit.dart';
import '../../global/widget/exception.dart';
import '../cubit/chat/cubit.dart';
import '../cubit/conversation/cubit.dart';
import '../cubit/conversation/states.dart';
import '../model/chat_user.dart';
import '../model/conversation.dart';
import '../repositories/message_repo.dart';
import '../repositories/service.dart';
import '../widget/conversation_field.dart';
import '../widget/empty_conversation_messages.dart';
import '../widget/message.dart';

class ConversationView extends StatelessWidget {
  static const id = 'conversation_view';

  final Conversation conversation;

  ConversationView({@required this.conversation, Key key})
      : assert(conversation != null),
        super(key: key);

  ChatUser _user(BuildContext context) {
    final userData = AuthCubit?.get(context)?.user?.data;

    return ChatService.getAnotherUser(
      users: conversation?.users,
      user: ChatUser(
        id: userData?.id.toString(),
        name: userData?.name,
        avatar: API.imageUrl(userData.avatar),
      ),
    );
  }

  final _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ConversationCubit.get(context).fetchMore();
      }
    });
  }

  final _msgP = const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConversationCubit>(
      create: (context) => ConversationCubit(
        conversation: conversation,
        user: ChatCubit.get(context).chatUser,
      ),
      child: Builder(
        builder: (context) {
          _setupScrollController(context);

          final cubit = ConversationCubit.get(context);

          return BlocConsumer<ConversationCubit, ConversationStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                    title: Text(_user(context).name,
                        style: TextStyle(color: Colors.grey[800]))),
                body: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: MessageRepo.conversationMessages(
                          roomData: cubit.conversation.roomData,
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const LoadingWidget();
                          } else if (snapshot.hasError) {
                            return ExceptionWidget(
                              onRefresh: () async {},
                              exceptionMsg: snapshot?.error?.toString() ?? '',
                            );
                          } else {
                            cubit.initialQuery(snapshot?.data?.docs ?? []);

                            if (cubit.messagesLength == 0) {
                              return const EmptyConversationMessagesWidget();
                            }

                            return ListView.separated(
                              controller: _scrollController,
                              reverse: true,
                              itemCount: cubit.messagesLength,
                              padding: _msgP,
                              itemBuilder: (context, index) {
                                index = (cubit.messagesLength - 1) - index;
                                return MessageWidget(
                                  message: cubit.messages[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10.0);
                              },
                            );
                          }
                        },
                      ),
                    ),
                    ConversationField(
                      loadingButton: state is SendingMessageState,
                      onSend: (value) async {
                        value = value.trim();
                        if (value != null && value.isNotEmpty) {
                          return cubit.sendMessage(value);
                        } else {
                          return false;
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
