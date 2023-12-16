import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';


@HiveType(typeId: 2)
class Currency extends HiveObject {
  Currency(
      {required this.id,
      required this.code,
      required this.symbol,
      required this.name,
      required this.rate,
      required this.lastUpdate});

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
        id: json["id"],
        code: json["code"],
        symbol: json["symbol"],
        name: json["name"],
        lastUpdate: (json["lastUpdate"] is String
            ? DateTime.parse(json["lastUpdate"]).toUtc()
            : (json["lastUpdate"] as Timestamp).toDate()),
        rate: json["rate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "symbol": symbol,
        "name": name,
        "lastUpdate": lastUpdate.toIso8601String(),
        "rate": rate,
      };
}
