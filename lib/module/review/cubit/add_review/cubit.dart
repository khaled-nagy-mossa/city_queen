import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/model/product_review.dart';
import '../../repositories/service.dart';

import 'states.dart';

class AddReviewCubit extends Cubit<AddReviewStates> {
  double _rate = 0.0;
  String review;
  final int productId;

  AddReviewCubit({@required this.productId}) : super(const InitialState(0.0));

  factory AddReviewCubit.get(BuildContext context) =>
      BlocProvider.of<AddReviewCubit>(context);

  double get rate => _rate ?? 0.0;

  set rate(double r) {
    _rate = r;
    emit(ChangedRateState(_rate));
  }

  String reviewValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'يجب كتابة تعليق';
    } else {
      return null;
    }
  }

  Future<void> submitReview() async {
    try {
      await Future<void>.delayed(Duration.zero);

      if (rate == 0.0) throw 'you must rate this product';

      emit(LoadingState(rate));
      final  result = await ReviewService.addReview(data: <String ,dynamic>{
        'product_id': productId,
        'rating_stars': rate,
        'feedback': review,
      });

      final myReview = ProductReview(rating: _rate, feedback: review);

      if (result == null || result.isEmpty) {
        emit(ReviewSubmittedState(myReview, rate));
      } else {
        emit(IneffectiveError(result, rate));
      }
    } catch (e) {
      log('Exception in AddReviewCubit._onAddReview : $e');
      emit(IneffectiveError(e.toString(), rate));
    }
  }
}
