import 'dart:convert';
import 'dart:developer';
import '../usage_criteria.dart';

class OrderBranch implements UsageCriteria {
  const OrderBranch({this.id, this.name});

  final int id;
  final String name;

  OrderBranch copyWith({int id, String name}) {
    try {
      return OrderBranch(id: id ?? this.id, name: name ?? this.name);
    } catch (e) {
      log('Exception in OrderBranch.copyWith : $e');
      return const OrderBranch();
    }
  }

  factory OrderBranch.fromJson(String str) {
    if (str == null || str.isEmpty) return const OrderBranch();

    try {
      return OrderBranch.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderBranch.fromJson : $e');
      return const OrderBranch();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderBranch.fromMap(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return const OrderBranch();
    try {
      return OrderBranch(
        id: json['id'] as int,
        name: json['name'] as String,
      );
    } catch (e) {
      log('Exception in OrderBranch.fromMap : $e');
      return const OrderBranch();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{'id': id, 'name': name};
    } catch (e) {
      log('Exception in OrderBranch.toMap : $e');
      return<String ,dynamic> {};
    }
  }


  @override
  // TODO: implement unUsable
  bool get unusable => throw UnimplementedError();

  @override
  // TODO: implement usable
  bool get usable => throw UnimplementedError();


}
