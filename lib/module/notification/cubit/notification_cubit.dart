import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/notification_list.dart';
import '../repositories/service.dart';
import 'notification_cubit_extension.dart';
import 'notification_states.dart';

class NotificationViewCubit extends Cubit<NotificationViewStates> {
  NotificationList notificationList;

  NotificationViewCubit() : super(const InitialState()) {
    init();
  }

  factory NotificationViewCubit.get(BuildContext context) {
    return BlocProvider.of<NotificationViewCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await NotificationService.getNotifications();

      if (result is String) throw result;

      if (result is NotificationList) {
        notificationList = result;

        if (hasData) {
          emit(const HasInitState());
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
      return;
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(Duration.zero);
    emit(const RefreshState());
    await init();
  }

  Future<void> deleteNotification(int id) async {
    try {
      await Future<void>.delayed(Duration.zero);

      emit(const LoadingState());

      final errorMsg =
          await NotificationService.removeNotification(notificationId: id);

      if (errorMsg != null && errorMsg.isNotEmpty) throw errorMsg;

      emit(const NotificationDeletedState());
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
