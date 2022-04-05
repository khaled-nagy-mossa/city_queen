import 'dart:developer';

class ReviewsParams {
  const ReviewsParams({
    this.productId,
    this.offset,
    this.limit = 10,
  });

  final int productId;
  final int offset;
  final int limit;

  ReviewsParams copyWith({
    int productId,
    int offset,
    int limit,
  }) {
    try {
      return ReviewsParams(
        productId: productId ?? this.productId,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
      );
    } catch (e) {
      log('Exception in ReviewsParams.copyWith : $e');
      return this;
    }
  }

  /// to parse params and get as url
  String get parse {
    var url = '';

    ///add params
    try {
      url += '?';

      if (productId != null) {
        url += 'product_id=$productId&';
      }
      if (limit != null && offset != null) {
        url += 'limit=$limit&offset=$offset&';
      }

      ///Erase extra marks
      if (url[url.length - 1] == '&') {
        url = url.substring(0, url.length - 1);
      }
      if (url[url.length - 1] == '?') {
        url = url.substring(0, url.length - 1);
      }

      return url;
    } catch (e) {
      log('Exception in ReviewsParams.parse :$e');
      return url;
    }
  }
}
