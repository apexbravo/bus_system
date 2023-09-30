import 'package:bus_system/models/Userrights.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Add this import for HiveObject

//part 'role.g.dart';

@HiveType(typeId: 3)
class Role extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Set<UserRights> rights;

  Role(this.name, this.rights);

  // Checking if a user has a specific right
  bool hasRight(UserRights right) {
    return rights.contains(right);
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rights':
          rights.map((right) => right.toString().split('.').last).toList(),
    };
  }

  // Deserialize from JSON
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      json['name'] as String,
      (json['rights'] as List<dynamic>)
          .map((right) => UserRights.values.firstWhere(
                (e) => e.toString().split('.').last == right,
              ))
          .where((element) => element != null)
          .toSet(),
    );
  }
}

// Creating a user role with specific rights
final adminRole = Role("Administrator", {
  UserRights.viewProducts,
  UserRights.addProduct,
  UserRights.editProduct,
  UserRights.deleteProduct,
  UserRights.viewSales,
  UserRights.addSale,
  UserRights.editSale,
  UserRights.deleteSale,
  UserRights.viewReports,
  UserRights.generateReports,
  UserRights.manageUsers,
  UserRights.manageSettings,
});

final cashierRole = Role("Cashier", {
  UserRights.viewProducts,
  UserRights.addSale,
  UserRights.viewSales,
});

// Checking if a user has a specific right
bool hasRight(Role role, UserRights right) {
  return role.rights.contains(right);
}
