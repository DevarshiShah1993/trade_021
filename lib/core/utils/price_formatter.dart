import 'package:intl/intl.dart';

/// Indian-grouping formatter (lakh/crore separators), e.g. 1,47,625.00.
class PriceFormatter {
  PriceFormatter._();

  static final NumberFormat _inr = NumberFormat.decimalPattern('en_IN');

  /// e.g. 147625.0 → "1,47,625.00"
  static String price(double value) {
    final whole = _inr.format(value.truncate());
    final frac = (value - value.truncate())
        .abs()
        .toStringAsFixed(2)
        .substring(2); // "00" out of "0.00"
    return '$whole.$frac';
  }

  /// e.g.  4.40 → "4.40"   |  -4.40 → "-4.40"  (sign carried through)
  static String change(double value) {
    return value.toStringAsFixed(2);
  }

  /// e.g. 0.32 → "0.32%"   |  -0.32 → "-0.32%"
  static String percent(double value) {
    return '${value.toStringAsFixed(2)}%';
  }
}
