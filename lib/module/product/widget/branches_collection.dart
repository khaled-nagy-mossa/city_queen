import 'dart:developer';

import 'package:flutter/material.dart';

import '../../branch/model/branch_availability.dart';
import 'package:get/get.dart';

class BranchesCollection extends StatelessWidget {
  final BoxShadow boxShadow;
  final RoundedRectangleBorder border;
  final List<BranchAvailability> branches;

  const BranchesCollection({
    @required this.branches,
    this.boxShadow,
    this.border,
  });

  RoundedRectangleBorder get _border {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (branches == null || branches.isEmpty) return const SizedBox();

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
                'Branches'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                height: 30.0,
                margin: const EdgeInsets.only(top: 20.0, bottom: 7.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: branches?.length ?? 0,
                  itemBuilder: (context, index) {
                    final branch = branches[index];
                    return _item(context, branch);
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

  Widget _item(BuildContext context, BranchAvailability branch) {
    try {
      if (branch == null || branch.unusable) return const SizedBox();

      return GestureDetector(
        onTap: () {
          // AppRoutes.push(context, BranchView(branch: branch));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(),
          ),
          child: Text(branch?.branchName),
        ),
      );
    } catch (e) {
      log('Exception in CategoriesCollection._item : $e'.tr);
      return const SizedBox();
    }
  }
}
