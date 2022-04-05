import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';
import '../../branch/model/branch.dart';
import 'home_view.dart';

class BranchesCollection extends HomeViewModel implements UsageCriteria {
  const BranchesCollection({
    this.name,
    this.branches,
  });

  final String name;
  final List<Branch> branches;

  BranchesCollection copyWith({
    String name,
    List<Branch> branches,
  }) {
    try {
      return BranchesCollection(
        name: name ?? this.name,
        branches: branches ?? this.branches,
      );
    } catch (e) {
      log('Exception in BranchesCollection.copyWith : $e');
      return this;
    }
  }

  factory BranchesCollection.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const BranchesCollection();

      return BranchesCollection.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in BranchesCollection.fromJson : $e');
      return const BranchesCollection();
    }
  }

  String toJson() => json.encode(toMap());

  factory BranchesCollection.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const BranchesCollection();

      return BranchesCollection(
        name: json['name'] as String,
        branches: List<Branch>.from(
          ((json['branches'] ?? <dynamic>[]) as List).map<Branch>(
            (dynamic x) => Branch.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in BranchesCollection.fromMap : $e');
      return const BranchesCollection();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'name': name,
        'branches': List<dynamic>.from(
            branches?.map<Map>((x) => x?.toMap()) ?? <Map>[]),
      };
    } catch (e) {
      log('Exception in BranchesCollection.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return name != null && branches != null;
    } catch (e) {
      log('Exception in SliderBanner.usable : $e');
      return false;
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in SliderBanner.unUsable : $e');
      return true;
    }
  }
}
