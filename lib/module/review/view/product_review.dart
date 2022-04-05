import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/empty_view.dart';
import '../../product/model/product.dart';
import '../../product/model/product_review_list.dart';
import '../cubit/reviews/cubit.dart';
import '../cubit/reviews/states.dart';
import '../widget/item.dart';
import 'package:get/get.dart';

class ProductReviewView extends StatelessWidget {
  static const String id = 'product_review_view';

  final ProductReviewList initialData;
  final Product product;

  ProductReviewView({
    @required this.initialData,
    @required this.product,
  }) : assert(product != null);

  final ScrollController _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    if (_scrollController.hasClients) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 250.0) {
          ReviewViewCubit.get(context).fetchMore();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);
    return BlocProvider<ReviewViewCubit>(
      create: (context) => ReviewViewCubit(productId: product.id),
      child: BlocConsumer<ReviewViewCubit, ReviewViewStates>(
        listener: (context, state) {
          if (state is IneffectiveErrorState) {
            AppSnackBar.error(context, state.error);
          }
          if (state is HasInitState) {
            _setupScrollController(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(title: Text(product.name ?? '')),
                body: _body(context, state),
              ),
              if (state is FetchingDataState) const AppLinearIndicator(),
              if (state is LoadingState) const LoadingWidget()
            ],
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, ReviewViewStates state) {
    final cubit = ReviewViewCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Reviews Found!'.tr,
        svgPath: Assets.images.categories,
        onRefresh: () async {
          await cubit.fetchMore();
        },
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.zero,
          child: ListView.separated(
            controller: _scrollController,
            itemCount: cubit?.reviewList?.reviews?.length ?? 0,
            itemBuilder: (context, index) {
              final review = cubit?.reviewList?.reviews[index];

              if (review == null || review.unusable) return const SizedBox();

              return ReviewItem(review: cubit?.reviewList?.reviews[index]);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
      );
    }
  }
}
