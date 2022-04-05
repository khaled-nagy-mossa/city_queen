import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/module/category/model/category.dart';
import 'package:softgrow/widget/linear_progress_indicator.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import 'package:get/get.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/empty_view.dart';
import '../cubit/categories/categories_cubit.dart';
import '../cubit/categories/categories_states.dart';
import '../model/category_list.dart';
import '../service/service.dart';
import '../widget/app_bar/app_bar.dart';
import '../widget/item.dart';

class CategoriesView extends StatelessWidget {
  static const String id = 'categories_view';

  final CategoryList initialData;

  CategoriesView({this.initialData, this.onCategoryTapped});

  final void Function(Category category) onCategoryTapped;

  final ScrollController _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 250.0) {
        CategoriesViewCubit.get(context).fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesViewCubit>(
      create: (context) => CategoriesViewCubit(initData: initialData),
      child: Builder(
        builder: (context) {
          return BlocConsumer<CategoriesViewCubit, CategoriesViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
              if (state is HasInitState) {
                _setupScrollController(context);
              }
            },
            builder: (context, state) {
              final cubit = CategoriesViewCubit.get(context);
              return Stack(
                children: [
                  Scaffold(
                    appBar: CategoriesViewAppBar(
                      title: 'All Categories'.tr,
                      onSearchClosed: cubit.closeSearch,
                      onSearch: cubit.search,
                      onChanged: cubit.search,
                    ),
                    body: Stack(
                      children: [
                        _body(context, state),
                        if (state is SearchState)
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: const AppLinearIndicator(),
                          ),
                      ],
                    ),
                  ),
                  if (state is FetchingDataState) const AppLinearIndicator(),
                  if (state is LoadingState) const LoadingWidget(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, CategoriesViewStates state) {
    final cubit = CategoriesViewCubit.get(context);
    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Categories Found!'.tr,
        svgPath: Assets.images.categories,
        onRefresh: () async {
          await cubit.refresh();
        },
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
          itemCount: cubit?.categoryList?.categories?.length ?? 0,
          gridDelegate: CategoryHelper.gridDelegate(context),
          itemBuilder: (context, index) {
            final category = cubit?.categoryList?.categories[index];
            if (category == null || category.unusable) return const SizedBox();
            return CategoryItem(
              onTap: onCategoryTapped == null
                  ? null
                  : () => onCategoryTapped(category),
              category: category,
            );
          },
        ),
      );
    }
  }
}
