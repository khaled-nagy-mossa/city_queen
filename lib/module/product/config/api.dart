import '../../../common/config/api.dart';

abstract class ProductAPIs {
  const ProductAPIs();

  //to get all app product list [params in ProductListParams class in model .. it is optional params]
  //type get
  //params =>url?branch_id=1&category_id=24&limit=5&offset=0&search=s
  static String productList = '${API.baseUrl}/product_list',
      //to get product by id [id is required]
      //type get
      //params => url?product_id=5
      getProduct = '${API.baseUrl}/get_product',
      //to get variant by attributes [id is required]
      //type get
      //params => ?limit=5&offset=0&product_id=5
      variantList = '${API.baseUrl}/variant_list',
      //to get variant by id [id is required]
      //type get
      //params => ?variant_id=43
      getVariant = '${API.baseUrl}/get_variant',
      //to get variant by attributes [required id and attributes send in request body]
      //type get
      //params => variantByAttr?product_id=5
      getVariantByAttr = '${API.baseUrl}/get_variant_by_attr',
      // filter
      filterParams = '${API.baseUrl}/filter_params';
}
