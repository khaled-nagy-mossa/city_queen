import '../../../common/config/api.dart';

abstract class CartAPIs {
  const CartAPIs();

  // Cart ######################################################################
  //to add variant to cart
  //type post
  //params => no params
  static final addToCart = '${API.baseUrl}/add_to_cart',
      //to get cart
      //type post
      //params => no params
      getCart = '${API.baseUrl}/get_cart',
      //to remove all cart data
      //type post
      //params => no params
      removeCart = '${API.baseUrl}/remove_cart';
}
