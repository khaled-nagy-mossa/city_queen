import '../abstract_category.dart';
import '../category.dart';

extension AbstractCategoryExtension on AbstractCategory {
  Category toCategory() {
    return Category.fromMap(toMap());
  }
}
