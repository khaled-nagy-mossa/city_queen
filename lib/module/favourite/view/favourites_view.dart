import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/cubit_extension.dart';
import '../../global/view/empty_view.dart';
import 'package:get/get.dart';
import '../cubit/favourites_cubit.dart';
import '../cubit/favourites_states.dart';
import '../widget/favourite_item.dart';

class FavouritesView extends StatelessWidget {
  static const String id = 'favorites_view';

  const FavouritesView();

  @override
  Widget build(BuildContext context) {
    if (AuthCubit?.get(context)?.signed == true) {
      FavouritesCubit.get(context).refresh();
    }

    return AuthListener(
      child: BlocConsumer<FavouritesCubit, FavouritesViewStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text('Favourite List'.tr,
                      style: TextStyle(color: Colors.grey[800])),
                ),
                body: _body(context, state),
              ),
              if (state is LoadingStates || state is RefreshState)
                const LoadingWidget()
            ],
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, FavouritesViewStates state) {
    final cubit = FavouritesCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Items Found!'.tr,
        svgPath: Assets.images.heart,
        onRefresh: () async {},
      );
    } else if (state is ExceptionState) {
      return Center(
        child: Text('exception : ${state.e}'.tr),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: cubit?.favouriteList?.variants?.length ?? 0,
          itemBuilder: (context, index) {
            final variant = cubit?.favouriteList?.variants[index];
            return FavouriteItem(
              variant: variant,
              onDelete: () {
                cubit.deleteFromFavouriteList(variant.id);
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(indent: 10.0, endIndent: 10.0, thickness: 1.0);
          },
        ),
      );
    }
  }
}
