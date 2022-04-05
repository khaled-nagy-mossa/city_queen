import '../../../common/config/api.dart';

abstract class ReviewAPIs {
  //get all product Reviews
  //type get
  //params => reviewsUrl?product_id=5&offset=0&limit=5
  static String reviews = '${API.baseUrl}/reviews',
      //to add review to product
      //type post
      //params => no params
      addReview = '${API.baseUrl}/add_review';
}
