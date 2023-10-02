import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Column(), currentTab: "Services");
  }
}
