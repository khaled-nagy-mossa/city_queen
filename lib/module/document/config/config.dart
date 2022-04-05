import '../../../common/config/api.dart';

abstract class DocumentAPIs {
  const DocumentAPIs();

//to get application contact us data
  //type get
  //params => no params
  static String contactUs = '${API.baseUrl}/contact_us',
      //get all Static pages
      //type get
      //params => ?page=typeOfPage [about_us , delivery_info , privacy_policy , terms_conditions , refund_policy]
      pages = '${API.baseUrl}/pages';
}
