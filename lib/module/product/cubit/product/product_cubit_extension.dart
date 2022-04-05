import 'product_cubit.dart';

///helper methods
extension ProductCubitExtension on ProductViewCubit {
  bool get hasProductData {
    return product != null && product.usable;
  }
}
