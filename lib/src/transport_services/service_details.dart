import 'package:bus_system/models/transport_service.dart';
import 'package:bus_system/src/helper.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ServiceDetails extends StatefulWidget {
  ServiceDetails({super.key, required this.service});
  TransportService service;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  Widget dataAttribute(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: "Services",
      appBar: AppBar(
        title: Text(widget.service.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dataAttribute("Name", widget.service.name),
            if (widget.service.category != null)
              dataAttribute("Category", widget.service.category!),
            if (widget.service.description != null)
              dataAttribute("Description", widget.service.description!),
            if (widget.service.price != null)
              dataAttribute("Cost", toMoney(widget.service.price!.amount))
          ],
        ),
      ),
    );
  }
}
