import 'dart:convert';

import 'dart:developer';

import '../../../model/usage_criteria.dart';

class Faq implements UsageCriteria {
  const Faq({
    this.id,
    this.question,
    this.answer,
  });

  final int id;
  final String question;
  final String answer;

  Faq copyWith({
    int id,
    String question,
    String answer,
  }) {
    try {
      return Faq(
        id: id ?? this.id,
        question: question ?? this.question,
        answer: answer ?? this.answer,
      );
    } catch (e) {
      log('Exception in Faq.copyWith : $e');
      return const Faq();
    }
  }

  factory Faq.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const Faq();

      return Faq.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in Faq.fromJson : $e');
      return const Faq();
    }
  }

  String toJson() => json.encode(toMap());

  factory Faq.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Faq();

      return Faq(
        id: json['id'] as int,
        question: json['question'] as String,
        answer: json['answer'] as String,
      );
    } catch (e) {
      log('Exception in Faq.fromMap : $e');
      return const Faq();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'id': id,
        'question': question,
        'answer': answer,
      };
    } catch (e) {
      log('Exception in Faq.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in Faq.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && question != null && answer != null;
    } catch (e) {
      log('Exception in Faq.unUsable : $e');
      return true;
    }
  }
}
