import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../home/model/branches_collection.dart';
import 'package:get/get.dart';
import '../model/branches_list.dart';
import '../view/branches_view.dart';
import 'branch_collection_item.dart';

class BranchesCollectionWidget extends StatelessWidget {
  final double height;
  final BranchesCollection itemsCollection;

  const BranchesCollectionWidget({
    @required this.itemsCollection,
    this.height = 200.0,
  });

  bool get isEmpty {
    return itemsCollection == null ||
        itemsCollection.branches == null ||
        itemsCollection.branches.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          ListTile(
            title: Text(
              itemsCollection.name ?? '',
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: TextButton(
              onPressed: () {
                AppRoutes.push(
                  context,
                  BranchesView(
                    initialData: BranchList(
                      count: itemsCollection.branches.length,
                      branches: itemsCollection.branches,
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
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              scrollDirection: Axis.horizontal,
              itemCount: itemsCollection.branches.length,
              itemBuilder: (context, index) {
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.2,
                    minWidth: MediaQuery.of(context).size.width / 1.2,
                  ),
                  child: BranchCollectionItem(
                    branch: itemsCollection.branches[index],
                  ),
                );
              },
            ),
          )
        ],
      );
    }
  }
}
