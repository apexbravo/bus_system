import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Column(), currentTab: "Services");
  }
}
