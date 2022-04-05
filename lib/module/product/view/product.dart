import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../cart/cubit/cart_states.dart' as cart_states;
import '../../global/view/empty_view.dart';
import '../../global/view/exception_view.dart';
import '../cubit/product/product_cubit.dart';
import '../cubit/product/product_states.dart';
import '../cubit/variant/variant_cubit.dart';
import '../cubit/variant/variant_states.dart' as variant_states;
import '../model/product.dart';
import '../widget/product_loading_view.dart';
import 'product_view_content.dart';
import 'package:get/get.dart';

class ProductView extends StatelessWidget {
  final Product product;
  final int productId;

  const ProductView({this.product, this.productId})
      : assert(product != null || productId != null);

  int get _productId {
    return product?.id ?? productId;
  }

  @override
  Widget build(BuildContext context) {
    try {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ProductViewCubit(product: product, productId: productId);
            },
          ),
          BlocProvider(create: (context) {
            return VariantCubit(ProductViewCubit.get(context));
          }),
        ],
        child: BlocConsumer<CartCubit, cart_states.CartStates>(
          listener: (context, state) {},
          builder: (context, cState) {
            return BlocConsumer<ProductViewCubit, ProductViewStates>(
              listener: (context, state) {
                if (state is IneffectiveErrorState) {
                  AppSnackBar.error(context, state.error);
                }
              },
              builder: (context, pState) {
                return BlocConsumer<VariantCubit, variant_states.VariantStates>(
                  listener: (context, state) {
                    if (state is variant_states.IneffectiveErrorState) {
                      AppSnackBar.error(
                          context, state?.error ?? 'Unknown Error'.tr);
                    }
                  },
                  builder: (context, vState) {
                    return Stack(
                      children: [
                        _body(context, pState),
                        ProductLoadingView(
                          cState: cState,
                          state: pState,
                          vState: vState,
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      );
    } catch (e) {
      log('Exception in ProductView : ${e.toString()}'.tr);

      return _exceptionView(context, e.toString());
    }
  }

  Widget _exceptionView(BuildContext context, String e) {
    return ExceptionView(
      onRefresh: () async {
        await ProductViewCubit.get(context).refresh(_productId);
      },
      exceptionMsg: e ?? 'Unknown Exception',
    );
  }

  Widget _body(BuildContext context, ProductViewStates state) {
    final cubit = ProductViewCubit.get(context);
    try {
      if (state is InitialState) {
        return const LoadingWidget(color: Colors.white);
      } else if (state is EmptyState) {
        return EmptyView(
          title: 'No Data Found!'.tr,
          svgPath: Assets.images.product,
          onRefresh: () async {
            await cubit.refresh(_productId);
          },
        );
      } else if (state is ExceptionState) {
        return _exceptionView(context, state?.error);
      } else {
        return ProductViewContent(productId: _productId);
      }
    } catch (e) {
      log('Exception in ProductView._body : ${e.toString()}'.tr);
      return _exceptionView(context, e.toString());
    }
  }
}
