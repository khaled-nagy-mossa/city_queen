import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

import 'home_view.dart';

class SliderBannerModel extends HomeViewModel implements UsageCriteria {
  const SliderBannerModel({
    this.banners,
  });

  final List<String> banners;

  SliderBannerModel copyWith({List<String> banners}) {
    try {
      return SliderBannerModel(banners: banners ?? this.banners);
    } catch (e) {
      log('Exception in SliderBanner.copyWith : $e');
      return this;
    }
  }

  factory SliderBannerModel.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const SliderBannerModel();

      return SliderBannerModel.fromMap(
          json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in SliderBanner.fromJson : $e');
      return const SliderBannerModel();
    }
  }

  String toJson() => json.encode(toMap());

  factory SliderBannerModel.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const SliderBannerModel();

      return SliderBannerModel(
        banners: List<String>.from(
          ((json['banners'] ?? <String>[]) as List)
              .map<String>((dynamic x) => x as String),
        ),
      );
    } catch (e) {
      log('Exception in SliderBanner.fromMap : $e');
      return const SliderBannerModel();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'banners': List<dynamic>.from(banners?.map<String>((x) => x)),
      };
    } catch (e) {
      log('Exception in SliderBanner.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get usable {
    try {
      return banners != null;
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
