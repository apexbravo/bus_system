import 'package:bus_system/models/transport_service.dart';

class InvoiceLine {
  TransportService service;
  double quantity;
  double unitCost;
  String? description;

  InvoiceLine({
    required this.service,
    required this.quantity,
    required this.unitCost,
    this.description,
  });

  String get subtitle {
    return '${service.category ?? ""} ${service.category != null && description != null ? "-" : ""} ${description ?? ""}';
  }
}
