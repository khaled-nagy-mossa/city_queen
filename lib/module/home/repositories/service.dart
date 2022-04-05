import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/banner.dart';
import '../model/branches_collection.dart';
import '../model/categories_collection.dart';
import '../model/home_view.dart';
import '../model/products_collection.dart';
import 'repo.dart';

abstract class HomeViewService {
  const HomeViewService();

  static Future homePage(LatLng latLng) async {
    try {
      final res = await HomeViewRepo.homePage(latLng);

      if (res.hasError) throw res.msg;

      return _listOfModel(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in homePage in PagesService: $e');
      return e.toString();
    }
  }

  static List<HomeViewModel> _listOfModel(Map<String, dynamic> json) {
    final models = <HomeViewModel>[];

    try {
      for (final obj in json['data']) {
        final model = _item(obj as Map<String, dynamic>);
        if (model != null) models.add(model);
      }

      return models;
    } catch (e) {
      log('Exception in HomeViewService._listOfModel : $e');
      return models;
    }
  }

  static HomeViewModel _item(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return null;

      final type = json['type'] as String;
      final data = json['data'] as Map<String, dynamic>;

      switch (type) {
        case 'categories':
          return CategoriesCollection.fromMap(data);
          break;
        case 'products':
          return ProductsCollection.fromMap(data);
          break;
        case 'branches':
          return BranchesCollection.fromMap(data);
          break;
        case 'banners':
          return SliderBannerModel.fromMap(data);
          break;
        default:
          return null;
      }
    } catch (e) {
      log('Exception in HomeViewService._item : $e');
      return null;
    }
  }
}
