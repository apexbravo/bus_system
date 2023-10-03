import 'package:bus_system/models/transport_service.dart';

class InvoiceLine {
  TransportService service;
  double quantity;
  double unitCost;

  InvoiceLine({
    required this.service,
    required this.quantity,
    required this.unitCost,
  });
}
