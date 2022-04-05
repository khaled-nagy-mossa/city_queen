import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../category/model/abstract_category.dart';
import '../../category/model/extension/abstract_category_extension.dart';
import '../../category/view/category_view.dart';
import 'package:get/get.dart';

class CategoriesCollection extends StatelessWidget {
  final BoxShadow boxShadow;
  final RoundedRectangleBorder border;
  final List<AbstractCategory> categories;

  const CategoriesCollection({
    @required this.categories,
    this.boxShadow,
    this.border,
  });

  RoundedRectangleBorder get _border {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (categories == null || categories.isEmpty) return const SizedBox();

      return Container(
        decoration: boxShadow == null
            ? const BoxDecoration()
            : BoxDecoration(boxShadow: [boxShadow]),
        child: Card(
          elevation: 0.0,
          shape: border ?? _border,
          margin: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ListTile(
              title: Text(
                'Categories'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                height: 30.0,
                margin: const EdgeInsets.only(top: 20.0, bottom: 7.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories?.length ?? 0,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return _item(context, category);
                  },
                ),
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      log('Exception in CategoriesCollection : $e'.tr);
      return const SizedBox();
    }
  }

  Widget _item(BuildContext context, AbstractCategory category) {
    try {
      if (category == null || category.unusable) return const SizedBox();

      return GestureDetector(
        onTap: () {
          AppRoutes.push(
              context, CategoryView(category: category.toCategory()));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(),
          ),
          child: Text(category?.name),
        ),
      );
    } catch (e) {
      log('Exception in CategoriesCollection._item : $e'.tr);
      return const SizedBox();
    }
  }
}
