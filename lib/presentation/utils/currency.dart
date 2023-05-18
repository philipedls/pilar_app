import 'package:intl/intl.dart';

extension CurrencyExtension on String {
  String currencyFormat() {
    var inBRFormat = NumberFormat.currency(locale: "pt_BR", symbol: "R\$");

    return inBRFormat.format(num.parse(this));
  }
}
