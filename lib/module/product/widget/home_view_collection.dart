import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../home/model/products_collection.dart';
import 'package:get/get.dart';
import '../model/product_list.dart';
import '../view/products.dart';
import 'product_item.dart';

class HomeViewProductsCollection extends StatelessWidget {
  final ProductsCollection collectionItems;

  const HomeViewProductsCollection({@required this.collectionItems});

  bool get isEmpty {
    return collectionItems == null ||
        collectionItems.products == null ||
        collectionItems.products.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const SizedBox();
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
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
                    ProductsView(
                      initialData: ProductList(
                        count: collectionItems.products.length,
                        products: collectionItems.products,
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
              constraints: const BoxConstraints(
                maxHeight: 200.0,
                minWidth: double.infinity,
              ),
              alignment: Alignment.topCenter,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemCount: collectionItems.products.length,
                itemBuilder: (context, index) {
                  return Container(
                    constraints: const BoxConstraints(),
                    height: 100.0,
                    width: 200.0,
                    child: ProductItem(
                      product: collectionItems.products[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
