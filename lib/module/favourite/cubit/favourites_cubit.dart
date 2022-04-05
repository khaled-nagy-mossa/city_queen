import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/states.dart' as auth_states;
import '../../product/model/variant_list.dart';
import '../repositories/favourite_service.dart';
import 'favourites_cubit_extension.dart';
import 'favourites_states.dart';

class FavouritesCubit extends Cubit<FavouritesViewStates> {
  VariantList favouriteList;

  final AuthCubit authCubit;
  StreamSubscription _streamSubscription;

  FavouritesCubit({@required this.authCubit}) : super(const InitialState()) {
    _streamSubscription = authCubit.stream.listen((event) {
      if (event is auth_states.SignedState) {
        log('auth_states.SignedState');
        init();
      } else if (event is auth_states.SignOutState) {
        clearCache();
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  factory FavouritesCubit.get(BuildContext context) {
    return BlocProvider.of<FavouritesCubit>(context);
  }

  /// to initial cubit data and if find error throw exception
  Future<void> init() async {
    try {
      await Future<void>.delayed(Duration.zero);

      final Object result = await FavouriteService.favorites();

      if (result is! VariantList) throw result.toString();

      if (result is VariantList) {
        if (result.unusable) throw 'unknown error';

        favouriteList = VariantList(
          count: result.count,
          variants: result.variants,
        );

        if (hasData) {
          emit(const HasInitState());
        } else {
          emit(const EmptyState());
        }
      }
    } catch (e) {
      emit(ExceptionState(e: e.toString()));
    }
  }

  Future<void> clearCache() async {
    await Future<void>.delayed(Duration.zero);
    favouriteList = const VariantList();
    emit(const HasInitState());
  }

  Future<void> refresh() async {
    await Future<void>.delayed(Duration.zero);
    emit(const RefreshState());
    await init();
  }

  Future<void> deleteFromFavouriteList(int variantId) async {
    assert(variantId != null);
    try {
      emit(RemovingVariantState(variantId: variantId));

      final Object result = await FavouriteService.removeFavorites(
        variantId: variantId,
      );

      if (result == null) {
        await init();
      } else {
        throw result.toString();
      }
    } catch (e) {
      emit(IneffectiveError(error: e.toString()));
    }
  }

  Future<void> addToFavouriteList(int variantId) async {
    assert(variantId != null);
    try {
      await Future<void>.delayed(Duration.zero);

      emit(AddingVariantState(variantId: variantId));

      final Object result = await FavouriteService.addToFavorites(
        variantId: variantId,
      );

      if (result == null) {
        await init();
        emit(AddedVariantState(variantId: variantId));
      } else {
        throw result;
      }
    } catch (e) {
      emit(IneffectiveError(error: e.toString()));
    }
  }

  Future<void> changeVariantFavouriteStatus(int variantId) async {
    if (variantId == null) return;
    if (contains(variantId)) {
      await deleteFromFavouriteList(variantId);
    } else {
      await addToFavouriteList(variantId);
    }
  }
}
