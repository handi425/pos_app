import 'package:intl/intl.dart';

class MoneyFormatter {
  MoneyFormatter._();

  static final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  static String format(int amountInCents) {
    return _currencyFormatter.format(amountInCents);
  }

  static String formatDouble(double value) {
    return _currencyFormatter.format(value);
  }
}
