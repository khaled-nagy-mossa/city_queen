import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/variant.dart';
import '../../repositories/product_service.dart';
import '../product/product_cubit.dart';
import '../product/product_states.dart' as product_states;
import 'variant_cubit_extension.dart';
import 'variant_states.dart';

class VariantCubit extends Cubit<VariantStates> {
  Variant variant;
  final ProductViewCubit _productViewCubit;
  StreamSubscription _streamSubscription;

  VariantCubit(this._productViewCubit) : super(const InitialState()) {
    _streamSubscription = _productViewCubit.stream.listen((event) {
      if (event is product_states.HasInitState) {
        final v = event?.product?.defaultVariant;
        if (v != null) loadVariant(variant: v);
      }
    });
    variant = const Variant();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  factory VariantCubit.get(BuildContext context) {
    return BlocProvider?.of<VariantCubit>(context);
  }

  //to initial _currentVariant by attributes
  //when user change any attribute the application must get the new variant
  //this method help for it => pass new attributes and this will get the new
  //variant and re initial the _currentVariant variable
  Future<void> loadVariant({
    List<int> attrId,
    Variant variant,
    int productId,
  }) async {
    assert(variant != null || (productId != null && attrId != null));

    await Future<void>.delayed(Duration.zero);

    try {
      emit(const LoadingVariantState());

      if (variant != null && variant.usable) {
        this.variant = variant;
        emit(const VariantLoadedState());
        return;
      } else {
        await _gettingVariantFromServer(productId, attrId);
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> _gettingVariantFromServer(int pId, List<int> attrId) async {
    try {
      final Object result = await ProductService.variantByAttributes(
        productId: pId,
        attrId: attrId,
      );

      if (result is String) throw result;

      if (result is Variant) {
        if (result.unusable) throw 'undefine variant';

        variant = result;

        if (hasVariantData) {
          emit(const VariantLoadedState());
        } else {
          throw 'Variant have not data';
        }
      }
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
