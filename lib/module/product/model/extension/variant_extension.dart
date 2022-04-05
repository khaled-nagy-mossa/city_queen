import 'dart:developer';

import '../../../branch/model/branch_availability.dart';
import '../variant.dart';

extension VariantExtension on Variant {
  bool get notAvailableBranch {
    try {
      return branchesAvailability == null || branchesAvailability.isEmpty;
    } catch (e) {
      log('Exception in VariantExtension.notAvailableBranch : $e');
      return true;
    }
  }

  BranchAvailability findBranchInAvailableVariantBranches(int id) {
    try {
      if (branchesAvailability == null || branchesAvailability.isEmpty) {
        return null;
      }

      BranchAvailability temp;

      for (final branch in branchesAvailability) {
        if (branch.branchId == id) {
          temp = branch;
          break;
        }
      }

      return temp;
    } catch (e) {
      log('Exception in VariantExtension.findBranchInAvailableVariantBranches : $e');
      return null;
    }
  }

  bool get availableInBranches {
    try {
      return branchesAvailability != null && branchesAvailability.isNotEmpty;
    } catch (e) {
      log('Exception in VariantExtension.availableInBranches : $e');
      return false;
    }
  }

  bool containBranchId(int id) {
    try {
      if (id == null || !availableInBranches) return false;

      BranchAvailability temp;

      for (final branch in branchesAvailability) {
        if (branch?.branchId == id) {
          temp = branch;
          break;
        }
      }

      return temp != null;
    } catch (e) {
      log('Exception in VariantExtension.containBranchById : $e');
      return false;
    }
  }

  List<int> getAttrIds() {
    try {
      if (attrValues == null || attrValues.isEmpty) return [];
      final ids = <int>[];

      for (final attributeValue in attrValues) {
        ids.add(attributeValue.id);
      }

      return ids;
    } catch (e) {
      log('Exception in VariantExtension.getAttrIds : $e');
      return <int>[];
    }
  }
}
