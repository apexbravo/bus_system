import 'package:bus_system/models/role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import 'guid.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  User({
    required this.name,
    required this.initials,
    required this.email,
    required this.userRole,
    this.tokenExpiryDate,
    this.isActive = false,
    this.password,
    this.lastLogin,
    this.creatorId,
    this.rightsId,
    this.phone,
  }) : id = Guid.newId();

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(3)
  String? password;

  @HiveField(4)
  String initials;

  @HiveField(5)
  String email;

  @HiveField(6)
  bool isActive;

  @HiveField(7)
  DateTime? lastLogin;

  @HiveField(8)
  String? creatorId;

  @HiveField(9)
  Role userRole;
  @HiveField(10)
  int? rightsId;

  @HiveField(11)
  DateTime? tokenExpiryDate;

  @HiveField(12)
  String? phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        password: json["password"],
        initials: json["initials"],
        email: json["email"],
        isActive: json["isActive"],
        lastLogin: json["lastLogin"],
        creatorId: json["creatorId"],
        userRole: Role.fromJson(json["userGroup"]),
        tokenExpiryDate: json['tokenExpiryDate'] != null
            ? (json['tokenExpiryDate'] is String
                ? DateTime.parse(json['tokenExpiryDate'])
                    .toUtc() // Parse and convert to DateTime
                : (json['tokenExpiryDate'] as Timestamp).toDate())
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "initials": initials,
        "email": email,
        "isActive": isActive,
        "lastLogin": lastLogin,
        "creatorId": creatorId,
        "userGroup": userRole.toJson(),
        'tokenExpiryDate': tokenExpiryDate != null
            ? tokenExpiryDate!
                .toUtc()
                .toIso8601String() // Convert to ISO 8601 format
            : null,
      };
}
