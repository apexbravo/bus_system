import 'package:hive/hive.dart';

import 'guid.dart';

@HiveType(typeId: 14)
class Customer extends HiveObject {
  Customer({
    required this.fullname,
    this.avatarUrl,
    required this.email,
    required this.phone,
    this.address,
  }) : id = Guid.newId();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fullname;

  @HiveField(2)
  final String? avatarUrl;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String? address;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        fullname: json["fullname"],
        avatarUrl: json["avatarUrl"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "avatarUrl": avatarUrl,
        "email": email,
        "phone": phone,
        "address": address,
      };
}
