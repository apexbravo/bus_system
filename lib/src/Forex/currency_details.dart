import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CurrencyDetails extends StatefulWidget {
  const CurrencyDetails({super.key});

  @override
  State<CurrencyDetails> createState() => _CurrencyDetailsState();
}

class _CurrencyDetailsState extends State<CurrencyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: currencyDetails(context),
    );
  }

  Widget currencyDetails(BuildContext context) {
    return AppScaffold(
        currentTab: "",
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
            // buildUserInfoDisplay(customer.fullname, 'Name'),
            // buildUserInfoDisplay(customer.phone, 'Phone'),
            // buildUserInfoDisplay(customer.email, 'Email'),
            // buildUserInfoDisplay(customer.address ?? ' ', 'Address'),
          ],
        ));
  }
}
