import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/module/product/view/search.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../global/view/empty_view.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/products/products_states.dart';
import '../model/product_list.dart';
import '../widget/products_grid_view.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  static const String id = 'products_view';

  final ProductList initialData;

  ProductsView({this.initialData});

  final ScrollController _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    if (_scrollController.hasClients) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 250.0) {
          ProductsCubit.get(context).fetchMore();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (context) => ProductsCubit(initData: initialData)..init(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ProductsCubit, ProductsStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
              if (state is HasInitState) {
                _setupScrollController(context);
              }
            },
            builder: (context, state) {
              final cubit = ProductsCubit.get(context);
              return Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      title: Text('All Products',
                          style: TextStyle(color: Colors.grey[800])),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            AppRoutes.push(context, SearchView());
                          },
                        ),
                      ],
                    ),
                    // appBar: SearchAppBar(
                    //   onSearch: cubit.search,
                    //   title: 'All Products'),
                    //   onSearchClosed: cubit.closeSearch,
                    //   onChanged: cubit.search,
                    // ),
                    body: _body(context, state),
                  ),
                  if (state is FetchingMoreState) const AppLinearIndicator(),
                  if (state is LoadingState)
                    Container(
                      color: Colors.grey.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, ProductsStates state) {
    final cubit = ProductsCubit.get(context);
    if (state is InitialState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Products Found!'.tr,
        svgPath: Assets.images.product,
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
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ProductsGridView(productList: cubit.productList),
        ),
      );
    }
  }
}
