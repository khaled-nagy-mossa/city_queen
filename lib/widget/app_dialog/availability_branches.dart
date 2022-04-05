import 'package:flutter/material.dart';

import '../../module/branch/model/branch_availability.dart';

class AvailabilityBranches extends StatelessWidget {
  final List<BranchAvailability> branches;
  final void Function(BranchAvailability branch) onSelect;

  const AvailabilityBranches({
    @required this.branches,
    @required this.onSelect,
  })  : assert(branches != null),
        assert(onSelect != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Choose Branch',
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: (branches?.map((e) => _item(context, e)) ?? []).toList(),
      ),
    );
  }

  Widget _item(BuildContext context, BranchAvailability b) {
    return GestureDetector(
      onTap: () {
        onSelect(b);
        Navigator.pop(context);
      },
      child: ListTile(title: Text(b?.branchName ?? '')),
    );
  }
}
