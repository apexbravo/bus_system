import 'package:hive/hive.dart';

import 'guid.dart';

@HiveType(typeId: 14)
class Currency extends HiveObject {
  Currency(
      {required this.code,
      required this.symbol,
      required this.name,
      required this.rate,
      required this.lastUpdate})
      : id = Guid.newId();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String code;

  @HiveField(3)
  final String symbol;

  @HiveField(4)
  final String name;
  @HiveField(5)
  final DateTime lastUpdate;
  @HiveField(6)
  final double rate;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
      code: json["code"],
      symbol: json["symbol"],
      name: json["name"],
      lastUpdate: DateTime.parse(json["checkOutDate"]),
      rate: json["rate"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "symbol": symbol,
        "name": name,
        "lastUpdate": lastUpdate.toIso8601String(),
        "rate": rate,
      };
}
