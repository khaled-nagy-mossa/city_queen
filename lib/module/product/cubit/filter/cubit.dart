import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/module/category/model/category.dart';
import 'package:softgrow/module/product/cubit/filter/states.dart';
import 'package:softgrow/module/product/model/filter.dart';
import 'package:softgrow/module/product/model/helper/product_list_params.dart';
import 'package:softgrow/module/product/repositories/product_service.dart';

class FilterCubit extends Cubit<FilterStates> {
  FilterCubit({ProductListParams params}) : super(const InitState()) {
    if (params != null) {
      _selectedIds = params.attrsValueIds;
    }
    fetchData();
  }

  Filter _filter;

  Filter get filter => _filter;

  Category _selectedCategory;

  Category get selectedCategory => _selectedCategory;

  set selectedCategory(Category category) {
    _selectedCategory = category;
    emit(CategorySelectedState(category: category));
  }

  List<int> _selectedIds = [];

  List<int> get selectedIds => _selectedIds ?? [];

  set selectedIds(List<int> ids) {
    _selectedIds = ids ?? [];
  }

  bool fun(FilterAttribute attribute) {
    for (final valueIds in attribute.valueIds) {
      if (_selectedIds.contains(valueIds.id)) {
        return true;
      }
    }

    return false;
  }

  void addId(int id) {
    if (selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }

    emit(SelectedIdsChangedState(selectedIds: selectedIds));
  }

  factory FilterCubit.get(BuildContext context) {
    return BlocProvider.of<FilterCubit>(context);
  }

  Future<void> fetchData() async {
    try {
      if (state is FetchingDataState) {
        return;
      }
      await Future<void>.delayed(Duration.zero);
      emit(const FetchingDataState());
      final result = await ProductService.filter();

      if (result is Filter) {
        _filter = result;
        emit(const FetchedDataState());
      } else {
        throw result;
      }
    } catch (e) {
      emit(ExceptionState(error: e.toString()));
    }
  }
}
