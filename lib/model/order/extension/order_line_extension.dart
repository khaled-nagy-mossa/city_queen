import '../order_line.dart';

extension OrderLineExtension on OrderLine {
  int quantity() {
    if (qty == null || qty == 0) {
      return 0;
    } else {
      return qty * -1;
    }
  }
}
