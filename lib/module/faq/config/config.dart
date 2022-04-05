import '../../../common/config/api.dart';

abstract class FaqAPIs {
  const FaqAPIs();

  //to get common questions
  //type get
  //params => faqsUrl?limit=5&offset=0
  static String getFaq = '${API.baseUrl}/get_faq';
}
