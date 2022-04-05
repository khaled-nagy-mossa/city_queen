import 'package:flutter/material.dart';

import '../../branch/widget/branches_collection.dart';
import '../../category/widget/home_view_categories_collection.dart';
import '../../product/widget/home_view_collection.dart';
import '../model/banner.dart';
import '../model/branches_collection.dart';
import '../model/categories_collection.dart';
import '../model/home_view.dart';
import '../model/products_collection.dart';
import 'banner.dart';

class HomeViewItem extends StatelessWidget {
  final HomeViewModel model;

  const HomeViewItem({@required this.model}) : assert(model != null);

  @override
  Widget build(BuildContext context) {
    if (model.unusable) return const SizedBox();

    if (model is CategoriesCollection) {
      return HomeViewCategoriesCollection(
        collectionItems: model as CategoriesCollection,
      );
    } else if (model is ProductsCollection) {
      return HomeViewProductsCollection(
        collectionItems: model as ProductsCollection,
      );
    } else if (model is BranchesCollection) {
      return BranchesCollectionWidget(
          itemsCollection: model as BranchesCollection);
    } else if (model is SliderBannerModel) {
      return SliderBanner(
        bannerModel: model as SliderBannerModel,
      );
    } else {
      return const SizedBox();
    }
  }
}
