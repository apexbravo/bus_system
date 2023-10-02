class Currency {
  String id;
  String? symbol;
  String name;
  String paymentMethodsJson;
  double exchangeRate;
  DateTime lastUpdate;

  Currency(
      {required this.id,
      this.symbol,
      required this.name,
      required this.paymentMethodsJson,
      required this.exchangeRate,
      required this.lastUpdate});
}
