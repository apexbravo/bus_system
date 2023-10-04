import 'package:flutter/material.dart';

import '../../models/db.dart';
import '../../models/invoice_line.dart';
import '../../models/transport_service.dart';
import '../helper.dart';

class ServiceList extends StatefulWidget {
  ServiceList({
    super.key,
    this.onTap,
    this.invoiceLines,
  });
  void Function(TransportService)? onTap;
  List<InvoiceLine>? invoiceLines;

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Db.services.length,
      itemBuilder: (BuildContext context, int index) {
        final service = Db.services[index];
        return ListTile(
          selectedTileColor: const Color(0xFFC9F2FF),
          selectedColor: Colors.black,
          selected: widget.invoiceLines != null
              ? widget.invoiceLines!
                  .any((element) => element.service.id == service.id)
              : false,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!(service);
            }
          },
          title: Text(service.name),
          subtitle: Text(service.category ?? ''),
          trailing: Text(service.price != null
              ? toMoney(service.price!.amount, Db.currencies.first)
              : ''),
        );
      },
    );
  }
}
