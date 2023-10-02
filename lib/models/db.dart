import 'package:bus_system/models/guid.dart';
import 'package:bus_system/models/transport_service.dart';

class Db {
  static List<TransportService> services = [
    TransportService(id: Guid.newId(), name: "Laugage"),
    TransportService(id: Guid.newId(), name: "Passenger"),
  ];
}
