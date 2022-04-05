import 'faq_cubit.dart';

extension FaqCubitExtension on FaqViewCubit {
  bool get hasData {
    return faqList != null && faqList.usable;
  }
}
