import 'package:bus_system/src/routes/add_route.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../theme/app_theme.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: "Routes",
      appBar: AppBar(
        title: const Text("Bus Routes"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRoute(),
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
