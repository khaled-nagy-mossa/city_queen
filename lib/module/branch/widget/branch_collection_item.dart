import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../../common/config/api.dart';
import 'package:get/get.dart';
import '../model/branch.dart';
import '../view/branch_view.dart';

class BranchCollectionItem extends StatelessWidget {
  final Branch branch;

  const BranchCollectionItem({@required this.branch}) : assert(branch != null);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: branch?.name ?? '',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
          onTap: () {
            AppRoutes.push(context, BranchView(branch: branch));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(API.imageUrl(branch.image)),
                    ),
                  ),
                ),
              ),
              Text(
                branch.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (branch.distance != null)
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.images.location,
                      width: 25.0,
                      color: Colors.white,
                    ),
                    Text(
                      '${branch.distance?.toString() ?? ''}${'km'.tr}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .merge(const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
