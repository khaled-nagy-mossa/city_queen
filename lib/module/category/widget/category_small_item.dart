import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../model/category.dart';
import '../view/category_view.dart';

class CategorySmallItem extends StatelessWidget {
  final Category category;
  final double height;

  const CategorySmallItem({@required this.category, this.height = 70.0})
      : assert(category != null);

  @override
  Widget build(BuildContext context) {
    try {
      if (category.unusable) throw 'un usable category';
      return Tooltip(
        message: category?.name ?? '',
        child: GestureDetector(
          onTap: () {
            AppRoutes.push(context, CategoryView(category: category));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: height,
                    maxHeight: height,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(API.imageUrl(category.image)),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: height),
                alignment: Alignment.center,
                child: Text(
                  category.name ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      log('Exception in CategorySmallItem : $e');
      return const SizedBox();
    }
  }
}
