import 'package:bus_system/models/currency.dart';
import 'package:bus_system/models/guid.dart';
import 'package:bus_system/models/payment_method.dart';
import 'package:bus_system/models/price.dart';
import 'package:bus_system/models/sub_route.dart';
import 'package:bus_system/models/transport_service.dart';

import 'Route.dart';

class Db {
  static List<Currency> currencies = [
    Currency(
      id: "USD",
      code: "USD",
      symbol: "US\$",
      name: "United States Dollar",
      rate: 1,
      lastUpdate: DateTime(2023, 9, 17),
    ),
    Currency(
      id: "ZWL",
      code: "ZWL",
      symbol: "\$",
      name: "Zimbabwean Dollar",
      rate: 6000,
      lastUpdate: DateTime(2023, 9, 17),
    ),
    Currency(
      id: "ZAR",
      code: "ZAR",
      symbol: "R",
      name: "South African Rand",
      rate: 20,
      lastUpdate: DateTime(2023, 9, 17),
    )
  ];
  static List<PaymentMethod> paymentMethods = [
    PaymentMethod(id: 0, name: "Cash", requireRef: false),
    PaymentMethod(id: 1, name: "Bank", requireRef: true),
    PaymentMethod(id: 2, name: "Pay on Delivery", requireRef: false)
  ];
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
  static List<Route> routes = [];
  static List<SubRoute> subRoutes = [];
}
