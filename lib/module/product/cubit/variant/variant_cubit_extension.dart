import 'variant_cubit.dart';

///helper methods
extension VariantCubitExtension on VariantCubit {
  bool get hasVariantData {
    return variant != null && variant.usable;
  }
}
