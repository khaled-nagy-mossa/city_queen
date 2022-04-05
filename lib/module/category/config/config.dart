import '../../../common/config/api.dart';

abstract class CategoryAPIs {
  const CategoryAPIs();

  //to get all Categories and category by id
  //type get
  //params => ?limit=10&offset=0&parent_id=2
  static String categoryList = '${API.baseUrl}/category_list',
      //to get category With Id
      //type get
      //params => getCategory?category_id=11
      getCategory = '${API.baseUrl}/get_category';
}
