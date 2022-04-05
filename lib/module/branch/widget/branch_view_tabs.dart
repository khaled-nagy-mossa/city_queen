import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'branch_tab.dart';

class BranchViewTabs extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onTap;

  const BranchViewTabs({@required this.selectedIndex, @required this.onTap})
      : assert(selectedIndex != null && onTap != null);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          children: [
            BranchTab(
              title: 'Products'.tr,
              selected: selectedIndex == 0,
              onTap: () {
                onTap(0);
              },
            ),
            BranchTab(
              title: 'Information'.tr,
              selected: selectedIndex == 1,
              onTap: () {
                onTap(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
