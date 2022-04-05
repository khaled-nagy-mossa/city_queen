import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/category_list.dart';
import '../../model/helper/category_list_params.dart';
import '../../repositories/category_service.dart';
import 'categories_cubit_extension.dart';
import 'categories_states.dart';

class CategoriesViewCubit extends Cubit<CategoriesViewStates> {
  CategoryList categoryList = const CategoryList();

  CategoryListParams params;

  CategoriesViewCubit({
    CategoryList initData,
    this.params = const CategoryListParams(offset: 0, limit: 20),
  }) : super(const InitialState()) {
    initialFromObject(initData);
    init();
  }

  factory CategoriesViewCubit.get(BuildContext context) {
    return BlocProvider.of<CategoriesViewCubit>(context);
  }

  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await CategoryService.categoryList(params: params);

      if (result is String) throw result;

      if (result is CategoryList) categoryList = result;

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
    if (state is FetchingDataState) return;

    ///use >= operator to more safety [Currently the server returns data if you send an offset : 1,000 and limit : 10,000 ] even if there are only 32 products
    if (categoryList.categories.length >= categoryList.count) {
      return;
    }

    try {
      emit(const FetchingDataState());

      increaseOffset();

      final Object result = await CategoryService.categoryList(params: params);

      if (result is String) throw result;

      if (result is CategoryList) {
        categoryList?.categories?.addAll(result?.categories ?? []);
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

  Future<void> search(String value) async {
    try {
      await Future<void>.delayed(Duration.zero);
      emit(const SearchState());
      params = params.copyWith(search: value, offset: 0);
      await init();
    } catch (e) {
      emit(IneffectiveErrorState(error: e.toString()));
    }
  }

  Future<void> closeSearch() async {
    await Future<void>.delayed(Duration.zero);
    emit(const SearchState());
    params = params.copyWith(search: '', offset: 0);
    await init();
  }
}
