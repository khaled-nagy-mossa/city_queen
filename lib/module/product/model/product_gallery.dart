import 'dart:convert';
import 'dart:developer';

import '../../../model/usage_criteria.dart';

class ProductGallery implements UsageCriteria {
  const ProductGallery({
    this.imageId,
    this.imageName,
    this.image128,
    this.image256,
    this.image512,
    this.image1024,
    this.image1920,
  });

  final int imageId;
  final String imageName;
  final String image128;
  final String image256;
  final String image512;
  final String image1024;
  final String image1920;

  ProductGallery copyWith({
    int imageId,
    String imageName,
    String image128,
    String image256,
    String image512,
    String image1024,
    String image1920,
  }) {
    try {
      return ProductGallery(
        imageId: imageId ?? this.imageId,
        imageName: imageName ?? this.imageName,
        image128: image128 ?? this.image128,
        image256: image256 ?? this.image256,
        image512: image512 ?? this.image512,
        image1024: image1024 ?? this.image1024,
        image1920: image1920 ?? this.image1920,
      );
    } catch (e) {
      log('Exception in ProductGallery.copyWith : $e');
      return const ProductGallery();
    }
  }

  factory ProductGallery.fromJson(String str) {
    if (str == null || str.isEmpty) return const ProductGallery();

    try {
      return ProductGallery.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ProductGallery.fromJson : $e');
      return const ProductGallery();
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductGallery.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const ProductGallery();

      return ProductGallery(
        imageId: json['image_id'] as int,
        imageName: json['image_name'] as String,
        image128: json['image_128'] as String,
        image256: json['image_256'] as String,
        image512: json['image_512'] as String,
        image1024: json['image_1024'] as String,
        image1920: json['image_1920'] as String,
      );
    } catch (e) {
      log('Exception in ProductGallery.fromMap : $e');
      return const ProductGallery();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'image_id': imageId,
        'image_name': imageName,
        'image_128': image128,
        'image_256': image256,
        'image_512': image512,
        'image_1024': image1024,
        'image_1920': image1920,
      };
    } catch (e) {
      log('Exception in ProductGallery.toMap : $e');
      return <String ,dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in ProductGallery.usable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return imageId == null &&
          imageName == null &&
          image128 == null &&
          image256 == null &&
          image512 == null &&
          image1024 == null &&
          image1920 == null;
    } catch (e) {
      log('Exception in ProductGallery.usable : $e');
      return false;
    }
  }
}
