import 'dart:developer';

import 'package:flutter/material.dart';
import '../model/product_list.dart';
import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  final ProductList productList;

  const ProductsGridView({@required this.productList})
      : assert(productList != null);

  //this method calculate gridDelegate
  //if current size can container 3 node return 3 if can contain 4 return 4
  SliverGridDelegate _gridDelegate(BuildContext context) {
    try {
      final temp =
          ((MediaQuery.of(context).size.width / 100).ceil() / 2.0).floor();
      return SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: temp);
    } catch (e) {
      log('Exception in ProductsGridView._gridDelegate : $e');
      return const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 50.0),
      itemCount: productList?.products?.length ?? 0,
      gridDelegate: _gridDelegate(context),
      itemBuilder: (context,  index) {
        final product = productList?.products[index];
        return ProductItem(product: product);
      },
    );
  }
}
