import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../model/category.dart';
import '../view/category_view.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({@required this.category, this.onTap})
      : assert(category != null);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    try {
      if (category.unusable) throw 'un usable category';
      return Tooltip(
        message: category?.name ?? '',
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap();
              } else {
                AppRoutes.push(context, CategoryView(category: category));
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image:
                              NetworkImage(API.imageUrl(category.image) ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  category.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6.merge(
                        const TextStyle(fontSize: 12.0),
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      log('Exception in CategoryItem : $e');
      return const SizedBox();
    }
  }
}
