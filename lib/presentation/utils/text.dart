import 'package:intl/intl.dart';

extension TextExtension on String {
  String currencyFormat() {
    var inBRFormat = NumberFormat.currency(locale: "pt_BR", symbol: "R\$");

    return inBRFormat.format(num.parse(this));
  }

  String normalize() {
    const diacritics = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const nonDiacritics = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    String label = this;

    for (int i = 0; i < diacritics.length; i++) {
      label = label.replaceAll(diacritics[i], nonDiacritics[i]);
    }

    return label;
  }
}
