import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import 'branch.dart';

class BranchList implements UsageCriteria {
  final int count;
  final List<Branch> branches;

  const BranchList({
    this.count,
    this.branches,
  });

  BranchList copyWith({int count, List<Branch> branches}) {
    try {
      return BranchList(
        count: count ?? this.count,
        branches: branches ?? this.branches,
      );
    } catch (e) {
      log('Exception in BranchList.copyWith : $e');
      return this;
    }
  }

  factory BranchList.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const BranchList();

      return BranchList.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in BranchList.fromJson : $e');
      return const BranchList();
    }
  }

  String toJson() => json.encode(toMap());

  factory BranchList.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const BranchList();

      return BranchList(
        count: json['count'] as int,
        branches: List<Branch>.from(
          ((json['branches'] ?? <Map>[]) as List).map<Branch>(
            (dynamic x) => Branch.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in BranchList.fromMap : $e');
      return const BranchList();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'count': count,
        'branches': List<dynamic>.from(
            branches?.map<Map>((x) => x?.toMap()) ?? <Map>[]),
      };
    } catch (e) {
      log('Exception in BranchList.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in BranchList.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return count != null && branches != null;
    } catch (e) {
      log('Exception in BranchList.unUsable : $e');
      return true;
    }
  }
}
