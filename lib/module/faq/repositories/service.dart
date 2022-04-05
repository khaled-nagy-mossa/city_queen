import '../model/faq_list.dart';
import 'repo.dart';

abstract class FaqService {
  const FaqService();

  static Future faqs({int offset, int limit = 10}) async {
    try {
      final res = await FaqRepo.getFaq(offset: offset, limit: limit);

      if (res.hasError) return res.msg;

      return FaqList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      return e.toString();
    }
  }
}
