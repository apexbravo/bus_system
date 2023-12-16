import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../helper.dart';

class InvoicePage extends StatefulWidget {
  InvoicePage({super.key, required this.invoice});
  Invoice invoice;

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        currentTab: 'Tickets',
        appBar: AppBar(
          title: Text(widget.invoice.number),
        ),
        body: Column(
          children: [
            const Text(
              "INVOICE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/barcodeImage.png',
              width: 120,
            ),
            Text(
              "Number: ${widget.invoice.number}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Date: ${widget.invoice.creationDate}"),
            const SizedBox(
              height: 8,
            ),
            const Text("CUSTOMER"),
            Text(widget.invoice.customer.fullname),
            Text(widget.invoice.customer.address ?? ''),
            Text("Tel: ${widget.invoice.customer.phone}"),
            const Divider(
              height: 4,
            ),
            Column(
              children: getItems(),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "TOTAL",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 24,
                ),
                Text(
                  toMoney(
                    widget.invoice.total,
                    widget.invoice.currency,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text("Print date: ${DateTime.now()}"),
          ],
        ));
  }

  List<Row> getItems() {
    List<Row> rows = [];
    for (var item in widget.invoice.lines) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(item.service.name),
              Text(item.subtitle),
            ],
          ),
          Text(
              "${widget.invoice.currency.symbol} ${toMoney(item.unitCost, widget.invoice.currency)}")
        ],
      ));
    }
    return rows;
  }
}
