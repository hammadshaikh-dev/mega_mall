import 'package:intl/intl.dart';

double parsePrice(String price) {
  final cleaned = price.replaceAll(RegExp(r'[^0-9]'), '');
  return double.tryParse(cleaned) ?? 0.0;
}

String formatPricePKR(double price) {
  final formatter = NumberFormat('#,##0', 'en_US');
  return 'PKR ${formatter.format(price)}';
}
