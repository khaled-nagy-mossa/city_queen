import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softgrow/module/filter/filter_screen.dart';
import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/empty_view.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/products/products_states.dart';
import '../model/helper/product_list_params.dart';
import '../widget/products_grid_view.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  static const String id = 'search_view';

  ProductListParams params;

  SearchView({this.params, Key key}) : super(key: key);

  final _scrollController = ScrollController();

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
      create: (context) {
        return ProductsCubit(params: params)..init();
      },
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
                      title: TextFormField(onChanged: cubit.search),
                      actions: [
                        GestureDetector(
                          onTap: () async {
                            final params =
                                await AppRoutes.push<ProductListParams>(
                              context,
                              FilterScreen(
                                  // comingFromSearchScreen: true,
                                  // initParams: cubit?.params,
                                  ),
                            );
                            if (params != null) {
                              await cubit.changeParams(params);
                            }
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: SvgPicture.asset(
                              Assets.images.filter,
                              width: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    body: _body(context, state),
                  ),
                  if (state is FetchingMoreState) const AppLinearIndicator(),
                  if (state is LoadingState) const LoadingWidget(),
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
