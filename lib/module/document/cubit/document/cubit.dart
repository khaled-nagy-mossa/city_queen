import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/service.dart';
import 'states.dart';

class DocumentViewCubit extends Cubit<DocumentViewStates> {
  String htmlData;
  String endPoint;

  DocumentViewCubit({@required this.endPoint})
      : assert(endPoint != null),
        super(const InitialState()) {
    init();
  }

  factory DocumentViewCubit.get(BuildContext context) {
    return BlocProvider.of<DocumentViewCubit>(context);
  }

  Future<void> init() async {
    try {
      htmlData = await DocumentService.staticPages(endPoint: endPoint);

      emit(const DataLoadedState());
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
      return;
    }
  }

  Future<void> refresh() async {
    emit(const LoadingState());
    await init();
  }
}
