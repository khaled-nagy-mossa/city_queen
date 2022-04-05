import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/product.dart';
import '../../model/product_review.dart';
import '../../repositories/product_service.dart';
import 'product_cubit_extension.dart';
import 'product_states.dart';

class ProductViewCubit extends Cubit<ProductViewStates> {
  Product product;

  ProductViewCubit({Product product, int productId})
      : super(const InitialState()) {
    init(product: product, productId: productId);
  }

  factory ProductViewCubit.get(BuildContext context) {
    return BlocProvider.of<ProductViewCubit>(context);
  }

  Future<void> init({Product product, int productId}) async {
    assert(product != null || productId != null);
    try {
      await Future<void>.delayed(Duration.zero); //to enable consumer listener

      if (product != null && product.usable) {
        this.product = product;
        emit(HasInitState(product: product));
        return;
      } else {
        await _initProductById(productId);
      }
    } catch (e) {
      emit(ExceptionState(product: product, error: e.toString()));
    }
  }

  Future<void> _initProductById(int productId) async {
    assert(productId != null);

    try {
      await Future<void>.delayed(Duration.zero); //to enable consumer listener

      final Object result = await ProductService.productById(productId);

      if (result is String) throw result;

      if (result is Product) {
        if (result.unusable) throw 'undefine product';

        product = result;

        if (hasProductData) {
          emit(HasInitState(product: product));
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> refresh(int id) async {
    try {
      await Future<void>.delayed(Duration.zero);

      emit(const LoadingState());

      await _initProductById(id);
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> changeMyReviewMember(ProductReview review) async {
    await Future<void>.delayed(Duration.zero);
    product = product.copyWith(myReview: review);
    emit(ChangeMyReviewMember());
  }
}
