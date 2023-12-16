import 'package:bus_system/models/currency.dart';
import 'package:bus_system/src/Forex/currency_details.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../theme/app_theme.dart';
import 'add_currency.dart';

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCurrency(),
              ),
            );
          },
          child: const Icon(
            FeatherIcons.plus,
            color: Colors.white,
          ),
        ),
        currentTab: "",
        appBar: AppBar(
          title: const Text("Currencies"),
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
                    return const Center(child: CircularProgressIndicator());
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
                              builder: (context) => CurrencyDetails(
                                currency: currency,
                              ),
                            ),
                          );
                        },
                        leading: const Text(""),
                        title: Text(currency.symbol),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(currency.name),
                              ],
                            ),
                            Text(currency.rate.toStringAsFixed(2)),
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
