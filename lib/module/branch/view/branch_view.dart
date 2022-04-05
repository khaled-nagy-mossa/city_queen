import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/empty_view.dart';
import 'package:get/get.dart';
import '../../product/cubit/products/products_cubit.dart';
import '../../product/cubit/products/products_states.dart' as product_status;
import '../../product/model/helper/product_list_params.dart';
import '../../product/widget/products_grid_view.dart';
import '../cubit/branch/branch_view_cubit.dart';
import '../cubit/branch/branch_view_states.dart';
import '../model/branch.dart';
import '../widget/branch_information.dart';
import '../widget/branch_view_tabs.dart';
import '../widget/sliver_app_bar.dart';

class BranchView extends StatelessWidget {
  static const String id = 'branch_view';

  final Branch branch;

  BranchView({@required this.branch}) : assert(branch != null);

  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  void _animateToPage({@required BuildContext context, @required int index}) {
    assert(context != null);
    assert(index != null);

    BranchViewCubit.get(context).currentPageViewIndex = index;

    _pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 500),
      curve: Curves.ease,
    );
  }

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 250.0) {
        ProductsCubit.get(context).fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BranchViewCubit()),
        BlocProvider(
          create: (context) => ProductsCubit(
            params: ProductListParams(branchId: branch.id),
          )..init(),
        ),
      ],
      child: BlocConsumer<BranchViewCubit, BranchViewStates>(
        listener: (context, state) async {
          if (state is IneffectiveErrorState) {
            AppSnackBar.error(context, state.error);
          }
        },
        builder: (context, state) {
          _setupScrollController(context);

          return BlocConsumer<ProductsCubit, product_status.ProductsStates>(
            listener: (context, state) async {},
            builder: (context, pState) {
              final bCubit = BranchViewCubit.get(context);

              return Stack(
                children: [
                  Scaffold(
                    backgroundColor: Colors.white,
                    body: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [BranchSliverAppBar(branch: branch)];
                      },
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BranchViewTabs(
                            selectedIndex: bCubit.currentPageViewIndex,
                            onTap: (index) {
                              _animateToPage(context: context, index: index);
                            },
                          ),
                          // page view [products of branch , branch information]
                          Expanded(
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                bCubit.currentPageViewIndex = index;
                              },
                              children: [
                                _branchProducts(context, pState),
                                BranchInformation(branch: branch),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is product_status.FetchingMoreState)
                    const AppLinearIndicator(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _branchProducts(
    BuildContext context,
    product_status.ProductsStates state,
  ) {
    final cubit = ProductsCubit.get(context);

    if (state is product_status.InitialState) {
      return const LoadingWidget();
    } else if (state is product_status.EmptyState) {
      return EmptyView(
        title: 'No Products Found!'.tr,
        svgPath: Assets.images.product,
        onRefresh: () async {
          await cubit.refresh();
        },
      );
    } else if (state is product_status.ExceptionState) {
      return Center(child: Text(state.error.toString()));
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: ProductsGridView(productList: cubit.productList),
      );
    }
  }
}
