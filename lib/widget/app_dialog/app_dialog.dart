import 'package:flutter/material.dart';

import '../../module/branch/model/branch_availability.dart';
import 'availability_branches.dart';
import 'exception_dialog.dart';
import 'loading_dialog.dart';
import 'location_permission_dialog.dart';
import 'must_sign.dart';
import 're_sign_dialog.dart';
import 'remove_branches_dialog.dart';

abstract class AppDialog {
  const AppDialog();

  static void loading(BuildContext context) {
    showDialog<Widget>(context: context, builder: (_) => const LoadingDialog());
  }

  static void mustSign(BuildContext context) {
    showDialog<Widget>(
      context: context,
      builder: (_) => const MustSignDialog(),
    );
  }

  static void location({
    @required BuildContext context,
    @required VoidCallback tryAgain,
  }) {
    showDialog<Widget>(
      context: context,
      builder: (_) => LocationPermissionLocation(tryAgain: tryAgain),
    );
  }

  static void reSign(BuildContext context) {
    showDialog<Widget>(
      context: context,
      builder: (_) => const ReSignDialog(),
    );
  }

  static void exception(BuildContext context) {
    showDialog<Widget>(
      context: context,
      builder: (_) => const ExceptionDialog(),
    );
  }

  static void showAvailabilityBranches({
    @required BuildContext context,
    @required List<BranchAvailability> branches,
    @required void Function(BranchAvailability branch) onSelect,
  }) {
    assert(context != null);
    assert(branches != null);
    assert(onSelect != null);

    showDialog<Widget>(
      context: context,
      builder: (context) {
        return AvailabilityBranches(branches: branches, onSelect: onSelect);
      },
    );
  }

  static void removeAllBranches({
    @required BuildContext context,
    @required VoidCallback onDelete,
  }) {
    assert(context != null);
    assert(onDelete != null);

    showDialog<Widget>(
      context: context,
      builder: (context) {
        return RemoveBranchesDialog(onDelete: onDelete);
      },
    );
  }
}
