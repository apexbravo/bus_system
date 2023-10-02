import 'package:bus_system/models/customer.dart';
import 'package:bus_system/models/enums/invoice_status.dart';
import 'package:bus_system/models/invoice_line.dart';
import 'package:bus_system/models/user.dart';

class Invoice {
  DateTime creationDate;
  String number;
  User creator;
  List<InvoiceLine> lines;
  InvoiceStatus status;
  double amountTendered;
  Customer customer;

  Invoice({
    required this.creationDate,
    required this.number,
    required this.creator,
    required this.lines,
    required this.status,
    required this.amountTendered,
    required this.customer,
  });
}
