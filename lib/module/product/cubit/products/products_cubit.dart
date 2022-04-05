import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/helper/product_list_params.dart';
import '../../model/product_list.dart';
import '../../repositories/product_service.dart';
import 'products_cubit_extension.dart';
import 'products_states.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductList productList = const ProductList();
  ProductListParams params;

  ProductsCubit({
    this.params = const ProductListParams(offset: 0),
    ProductList initData,
  }) : super(const InitialState()) {
    initialFromObject(initData);

    params = params?.copyWith(offset: 0);
  }

  factory ProductsCubit.get(BuildContext context) {
    return BlocProvider?.of<ProductsCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero); //for bloc consumer safety

      emit(const LoadingState());

      final Object result = await ProductService.productList(params: params);

      if (result is String) throw result;

      if (result is ProductList) productList = result;

      if (isEmpty) {
        emit(const EmptyState());
      } else {
        emit(const HasInitState());
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }

  Future<void> fetchMore() async {
    if (state is FetchingMoreState) return;

    ///use >= operator to more safety [Currently the server returns data if you send an offset : 1,000 and limit : 10,000 ] even if there are only 32 products
    if (productList.products.length >= productList.count) {
      return;
    }

    try {
      emit(const FetchingMoreState());

      increaseOffset();

      final Object result = await ProductService.productList(params: params);

      if (result is String) throw result;

      if (result is ProductList) {
        productList?.products?.addAll(result?.products ?? []);
      }

      emit(const HasFetchedMoreState());
    } catch (e) {
      decreaseOffset();
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> changeParams(ProductListParams param) async {
    if (params == null) {
      params = param;
      await refresh();
      return;
    }
    params = params.copyWith(
      categoryId: param.categoryId,
      attrsValueIds: param.attrsValueIds,
      search: param.search,
      branchId: param.branchId,
    );
    await refresh();
  }

  Future<void> refresh() async {
    try {
      await Future<void>.delayed(Duration.zero);

      resetCubitData();

      await init();
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> search(String value) async {
    try {
      await Future<void>.delayed(Duration.zero);
      params = ProductListParams(search: value, offset: 0);
      // params = params.copyWith(search: value, offset: 0);
      await init();
    } catch (e) {
      print("error search is : $e");
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> closeSearch() async {
    try {
      await Future<void>.delayed(Duration.zero);
      params = params.copyWith(search: '', offset: 0);
      await init();
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }
}
