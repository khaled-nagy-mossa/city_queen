import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import 'package:get/get.dart';
import '../model/branch.dart';
import '../view/branch_view.dart';

class BranchItem extends StatelessWidget {
  final Branch branch;

  const BranchItem({@required this.branch})
      : assert(branch != null, 'branch must not be null');

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: branch?.name ?? '',
      child: Container(
        height: 200.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            AppRoutes.push(context, BranchView(branch: branch));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(API.imageUrl(branch.image)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      branch?.name ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    if (branch.distance != null)
                      Text(
                        '${branch.distance}${'km'.tr}',
                        style: Theme.of(context).textTheme.caption,
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
