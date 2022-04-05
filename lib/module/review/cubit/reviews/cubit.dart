import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/model/product_review_list.dart';
import '../../model/reviews_params.dart';
import '../../repositories/service.dart';
import 'cubit_extension.dart';
import 'states.dart';

class ReviewViewCubit extends Cubit<ReviewViewStates> {
  ProductReviewList reviewList;
  ReviewsParams params;

  ReviewViewCubit({@required int productId, ProductReviewList initData})
      : assert(productId != null),
        super(const InitialState()) {
    params = ReviewsParams(productId: productId, limit: 20);

    initialFromObject(initData);
    init();
  }

  factory ReviewViewCubit.get(BuildContext context) {
    return BlocProvider.of<ReviewViewCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await ReviewService.reviews(params: params);

      if (result is String) throw result;

      if (result is ProductReviewList) {
        reviewList = result;

        if (hasReviews) {
          emit(const HasInitState());
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> fetchMore() async {
    if (state is FetchingDataState) return;

    ///use >= operator to more safety [Currently the server returns data if you send an offset : 1,000 and limit : 10,000 ] even if there are only 32 products
    if (reviewList.reviews.length >= reviewList.reviewsCount) {
      return;
    }

    try {
      emit(const FetchingDataState());

      increaseOffset();

      final Object result = await ReviewService.reviews(params: params);

      if (result is String) throw result;

      if (result is ProductReviewList) {
        reviewList?.reviews?.addAll(result?.reviews ?? []);
      }

      emit(const HasFetchedMoreState());
    } catch (e) {
      decreaseOffset();
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      await Future<void>.delayed(Duration.zero);

      resetCubitData();

      await init();
    } catch (e) {
      IneffectiveErrorState(error: e.toString());
    }
  }
}
