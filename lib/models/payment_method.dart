import 'dart:convert';
import 'package:hive/hive.dart';

@HiveType(typeId: 8)
class PaymentMethod extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool requireRef;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.requireRef,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"] ?? json["Id"],
        name: json["name"] ?? json["Name"],
        requireRef: json["requireRef"] ?? json["RequireRef"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "requireRef": requireRef,
      };
}
