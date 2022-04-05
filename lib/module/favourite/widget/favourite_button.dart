import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../auth/auth_observer/auth_middle_ware.dart';
import '../cubit/favourites_cubit.dart';
import '../cubit/favourites_cubit_extension.dart';
import '../cubit/favourites_states.dart';

class FavouriteButton extends StatelessWidget {
  final int variantId;

  const FavouriteButton({@required this.variantId});

  Widget _loading() {
    return Container(
      height: 20.0,
      width: 20.0,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (variantId == null) return const SizedBox();

    final cubit = FavouritesCubit.get(context);

    try {
      return BlocConsumer<FavouritesCubit, FavouritesViewStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddingVariantState && state.variantId == variantId) {
            return _loading();
          }
          if (state is RemovingVariantState && state.variantId == variantId) {
            return _loading();
          }
          return GestureDetector(
            onTap: () {
              authMiddleWare(
                context: context,
                action: () async {
                  await cubit.changeVariantFavouriteStatus(variantId);
                },
              );
            },
            child: Container(
              constraints: const BoxConstraints(),
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(
                cubit.contains(variantId)
                    ? Assets.images.filledHeart
                    : Assets.images.heart,
                color: cubit.contains(variantId)
                    ? Theme.of(context).primaryColor
                    : null,
              ),
            ),
          );
        },
      );
    } catch (e) {
      log('Exception in FavouriteButton : $e');
      return const SizedBox();
    }
  }
}
