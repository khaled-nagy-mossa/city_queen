import '../../../product/model/product_review_list.dart';
import 'cubit.dart';

extension ReviewViewCubitExtension on ReviewViewCubit {
  void initialFromObject(ProductReviewList initData) {
    if (initData == null) return;

    reviewList = ProductReviewList(
      reviewsCount: initData.reviewsCount,
      reviews: initData.reviews,
      ratingAvg: initData.ratingAvg,
    );
  }

  bool get hasReviews {
    if (reviewList == null ||
        reviewList.reviewsCount == null ||
        reviewList.reviewsCount == 0 ||
        reviewList.reviews == null ||
        reviewList.reviews.isEmpty) {
      return false;
    }
    return true;
  }

  void resetCubitData() {
    /// comment this to show data in the background in screen
    // filteredProductList = const ProductList();
    // productList = const ProductList();

    resetOffset();
  }

  void increaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? -10) + 10);
  }

  void decreaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? 10) - 10);
  }

  void resetOffset() {
    params = params.copyWith(offset: 0);
  }
}
