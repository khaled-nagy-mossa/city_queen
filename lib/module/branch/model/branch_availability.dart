import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class BranchAvailability implements UsageCriteria {
  const BranchAvailability({
    this.branchId,
    this.branchName,
    this.quantity,
  });

  final int branchId;
  final String branchName;
  final int quantity; //returned from backend as double

  BranchAvailability copyWith({
    int branchId,
    String branchName,
    int quantity,
  }) {
    try {
      return BranchAvailability(
        branchId: branchId ?? this.branchId,
        branchName: branchName ?? this.branchName,
        quantity: quantity ?? this.quantity,
      );
    } catch (e) {
      log('Exception in BranchAvailability.copyWith : $e');
      return this;
    }
  }

  factory BranchAvailability.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const BranchAvailability();

      return BranchAvailability.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in BranchAvailability.fromJson : $e');
      return const BranchAvailability();
    }
  }

  String toJson() => json.encode(toMap());

  factory BranchAvailability.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const BranchAvailability();

      return BranchAvailability(
        branchId: json['branch_id'] as int,
        branchName: json['branch_name'] as String,
        quantity: json['quantity'].toInt() as int,
      );
    } catch (e) {
      log('Exception in BranchAvailability.fromMap : $e');
      return const BranchAvailability();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'branch_id': branchId,
        'branch_name': branchName,
        'quantity': quantity,
      };
    } catch (e) {
      log('Exception in BranchAvailability.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in BranchAvailability.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return branchId != null && branchName != null;
    } catch (e) {
      log('Exception in BranchAvailability.unUsable : $e');
      return true;
    }
  }
}
