import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../global/view/empty_view.dart';
import '../../global/view/exception_view.dart';
import '../cubit/notification_cubit.dart';
import '../cubit/notification_states.dart';
import '../widget/notification_item.dart';

class NotificationsView extends StatelessWidget {
  static const String id = 'notifications_view';

  const NotificationsView();

  @override
  Widget build(BuildContext context) {
    try {
      return AuthListener(
        child: BlocProvider<NotificationViewCubit>(
          create: (context) => NotificationViewCubit(),
          child: BlocConsumer<NotificationViewCubit, NotificationViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      title: Text('Notifications'.tr,
                          style: TextStyle(color: Colors.grey[800])),
                    ),
                    body: _body(context, state),
                  ),
                  if (state is LoadingState) const LoadingWidget(),
                ],
              );
            },
          ),
        ),
      );
    } catch (e) {
      return ExceptionView(
        onRefresh: () async {
          await NotificationViewCubit.get(context).refresh();
        },
        exceptionMsg: e.toString(),
      );
    }
  }

  Widget _body(BuildContext context, NotificationViewStates state) {
    final cubit = NotificationViewCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Notifications Found!'.tr,
        svgPath: Assets.images.location,
        onRefresh: () async {
          await cubit.refresh();
        },
      );
    } else if (state is ExceptionState) {
      return ExceptionView(
        onRefresh: () async {
          await cubit.refresh();
        },
        exceptionMsg: state?.error ?? '',
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: cubit?.notificationList?.notifications?.length ?? 0,
          itemBuilder: (context, index) {
            final notification = cubit?.notificationList?.notifications[index];

            if (notification == null || notification.unusable) {
              return const SizedBox();
            }

            return NotificationItem(
              notification: notification,
              onDelete: () {
                cubit.deleteNotification(notification?.id);
              },
            );
          },
        ),
      );
    }
  }
}
