import 'package:bus_system/src/transport_services/add_service.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../theme/app_theme.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {},
          ),
        ],
      ),
      body: const Column(),
      currentTab: "Services",
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddService(),
            ),
          );
        },
        child: const Icon(
          FeatherIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
