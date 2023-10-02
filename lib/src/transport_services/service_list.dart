import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({super.key});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Column(), currentTab: "Services");
  }
}
