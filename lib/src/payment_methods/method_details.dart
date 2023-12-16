import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class MethodDetails extends StatefulWidget {
  const MethodDetails({super.key});

  @override
  State<MethodDetails> createState() => _MethodDetailsState();
}

class _MethodDetailsState extends State<MethodDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: methodDetails(context),
    );
  }

  Widget methodDetails(BuildContext context) {
    return AppScaffold(
      currentTab: "",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: const Column(
              children: [
                Text("Payment method"),
                SizedBox(
                  height: 10,
                ),
                Text("Cash"),
                SizedBox(
                  height: 10,
                ),
                Text("Payment reference")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
