import '../../../common/config/api.dart';

abstract class HomeAPIs {
  const HomeAPIs();

  //to get all home page data
  //type get
  //params => homePageUrl?lat=29.9973063&lng=31.3108363 [send location to get near branches]
  static final homePage = '${API.baseUrl}/homepage';
}
