import '../models/currency.dart';

String toMoney(double value, Currency currency) {
  return "${currency.symbol}${value.toStringAsFixed(2)}";
}
