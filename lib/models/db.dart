import 'package:bus_system/models/guid.dart';
import 'package:bus_system/models/price.dart';
import 'package:bus_system/models/transport_service.dart';

class Db {
  static List<TransportService> services = [
    TransportService(id: Guid.newId(), name: "Laugage", category: "Laugage"),
    TransportService(
      id: Guid.newId(),
      name: "Bulawayo - Harare",
      category: "Passengers",
      price: Price(amount: 15),
    ),
    TransportService(
      id: Guid.newId(),
      name: "Bulawayo - Gweru",
      category: "Passengers",
      price: Price(amount: 5),
    ),
    TransportService(
      id: Guid.newId(),
      name: "Bulawayo - Kwekwe",
      category: "Passengers",
      price: Price(amount: 8),
    ),
    TransportService(
      id: Guid.newId(),
      name: "Bulawayo - Kadoma",
      category: "Passengers",
      price: Price(amount: 10),
    ),
    TransportService(
      id: Guid.newId(),
      name: "Bulawayo - Chegutu",
      category: "Passengers",
      price: Price(amount: 12),
    ),
    TransportService(
      id: Guid.newId(),
      name: "Harare - Chegutu",
      category: "Passengers",
      price: Price(amount: 3),
    ),
    TransportService(
      id: Guid.newId(),
      name: "Harare - Kadoma",
      category: "Passengers",
      price: Price(amount: 5),
    ),
    TransportService(
      id: Guid.newId(),
      name: "Bulawayo - Kwekwe",
      category: "Passengers",
      price: Price(amount: 8),
    ),
  ];
}
