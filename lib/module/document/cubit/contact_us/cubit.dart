import 'package:app_launcher/app_launcher.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/contact_us.dart';
import '../../repositories/service.dart';
import 'states.dart';

class ContactUsViewCubit extends Cubit<ContactUSViewStates> {
  ContactUs contactUs;

  ContactUsViewCubit() : super(const InitialState()) {
    init();
  }

  factory ContactUsViewCubit.get(BuildContext context) {
    return BlocProvider.of<ContactUsViewCubit>(context);
  }

  bool get hasData => contactUs != null;

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await DocumentService.contactUs();

      if (result is String) throw result;

      if (result is ContactUs) contactUs = result;

      if (hasData) {
        emit(const HasInitState());
      } else {
        emit(const EmptyState());
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
      return;
    }
  }

  Future<void> refresh() async {
    emit(const RefreshState());
    await init();
  }

  //launch to social media web sites [facebook , twitter ,...etc]
  Future<void> launchUrl(BuildContext context, String url) async {
    try {
      if (url != null || url.isNotEmpty) {
        final error = await AppLauncher.launchUrl(url);

        if (error != null && error.isNotEmpty) throw error;
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  //launch to phone
  Future<void> launchToPhone(BuildContext context, String phone) async {
    try {
      if (phone != null || phone.isNotEmpty) {
        final error = await AppLauncher.launchToPhone(phone);

        if (error != null && error.isNotEmpty) throw error;
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> launchToEmail(BuildContext context, String email) async {
    try {
      if (email != null || email.isNotEmpty) {
        final error = await AppLauncher.launchUrl('mailto:$email');

        if (error != null && error.isNotEmpty) throw error;
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
