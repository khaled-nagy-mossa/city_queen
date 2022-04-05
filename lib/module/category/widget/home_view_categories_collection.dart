import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../home/model/categories_collection.dart';
import 'package:get/get.dart';
import '../model/category_list.dart';
import '../view/categories_view.dart';
import 'category_small_item.dart';

class HomeViewCategoriesCollection extends StatelessWidget {
  final CategoriesCollection collectionItems;
  final double height;

  const HomeViewCategoriesCollection({
    @required this.collectionItems,
    this.height = 100.0,
  });

  bool get isEmpty {
    return collectionItems == null ||
        collectionItems.categories == null ||
        collectionItems.categories.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    try {
      return isEmpty
          ? const SizedBox()
          : Column(
              children: [
                ListTile(
                  title: Text(
                    collectionItems.name ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      AppRoutes.push(
                        context,
                        CategoriesView(
                          initialData: CategoryList(
                            count: collectionItems.categories.length,
                            categories: collectionItems.categories,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'SEE ALL'.tr,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: height,
                    minHeight: height,
                    minWidth: double.infinity,
                  ),
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: collectionItems.categories.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemBuilder: (context, index) {
                      return CategorySmallItem(
                        category: collectionItems.categories[index],
                        height: height / 1.7,
                      );
                    },
                  ),
                ),
              ],
            );
    } catch (e) {
      log('Exception in HomeViewCategoriesCollection : $e'.tr);
      return const SizedBox();
    }
  }
}
