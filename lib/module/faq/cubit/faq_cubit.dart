import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/faq_list.dart';
import '../repositories/service.dart';
import 'faq_cubit_extension.dart';
import 'faq_states.dart';

class FaqViewCubit extends Cubit<FaqViewStates> {
  FaqList faqList;
  int currentOffset;

  FaqViewCubit() : super(const InitialState()) {
    init();
  }

  factory FaqViewCubit.get(BuildContext context) {
    return BlocProvider.of<FaqViewCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      currentOffset = 0;

      final Object result = await FaqService.faqs(offset: currentOffset);

      if (result is String) throw result.toString();

      if (result is FaqList) {
        if (result.unusable) throw 'UnDefine FAQs';

        faqList = result;

        if (hasData) {
          emit(const HasInitState());
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(e: e.toString()));
    }
  }

  Future<void> refresh() async {
    await Future<void>.delayed(Duration.zero);
    emit(const LoadingState());
    await init();
  }
}
