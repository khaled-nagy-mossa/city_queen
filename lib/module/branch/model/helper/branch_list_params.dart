import 'dart:developer';

class BranchListParams {
  const BranchListParams({
    this.topBranches = false,
    this.offset,
    this.limit = 10,
    this.lang,
    this.lat,
  });

  final int limit;
  final int offset;
  final bool topBranches;
  final double lang;
  final double lat;

  BranchListParams copyWith({
    int limit,
    int offset,
    bool topBranches,
    double lang,
    double lat,
  }) {
    try {
      return BranchListParams(
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        topBranches: topBranches ?? this.topBranches,
        lang: lang ?? this.lang,
        lat: lat ?? this.lat,
      );
    } catch (e) {
      log('Exception in BranchListParams.copyWith : $e');
      return this;
    }
  }

  /// to parse params and get as url
  String get parse {
    var url = '';

    ///add params
    try {
      url += '?';

      if (limit != null && offset != null) {
        url += 'limit=$limit&offset=$offset&';
      }

      if (lat != null && lang != null) {
        url += 'lat=$lat&lng=$lang&';
      }

      if (topBranches == true) {
        url += 'top_branch=true';
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
      log('Exception in BranchListParams.parse :$e');
      return url;
    }
  }
}
