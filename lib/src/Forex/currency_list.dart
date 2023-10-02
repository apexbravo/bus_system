import 'package:bus_system/models/currency.dart';
import 'package:bus_system/src/Forex/currency_details.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CurrencyList extends StatefulWidget {
  const CurrencyList({super.key});

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: currencyMobile(context),
    );
  }

  Widget currencyMobile(BuildContext context) {
    return AppScaffold(
        currentTab: "",
        appBar: AppBar(
          title: Text("Currencies"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('currencies')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final List<Currency> currencies = snapshot.data!.docs
                      .map((doc) => Currency.fromJson(doc.data()))
                      .toList();

                  return ListView.builder(
                    itemCount: currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currency = currencies[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CurrencyDetails(),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                        title: Text(currency.code ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(currency.name ?? ''),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
