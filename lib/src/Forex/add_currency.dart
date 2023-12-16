import 'package:bus_system/models/currency.dart';
import 'package:bus_system/models/guid.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'currency_list.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({Key? key}) : super(key: key);

  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  final _formKey = GlobalKey<FormState>();
  late String code;
  late String _curencyName;
  late String _symbol;
  late double exchangeRate;
  late DateTime lastUpdate;

  void saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    final newCurrency = Currency(
        id: Guid.newId(),
        code: code,
        name: _curencyName,
        rate: exchangeRate,
        lastUpdate: DateTime.now(),
        symbol: _symbol);
    // Convert the Customer object to a map
    final currencyMap = newCurrency.toJson();
// Add the customer data to the "users" collection in Firestore
    FirebaseFirestore.instance
        .collection("currencies")
        .add(currencyMap)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'))
        .catchError((error) => print('Error adding currency: $error'));

    // You can now do something with the newCustomer object, like adding it to a list or storing it in a database.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CurrencyList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: addCurrency(context),
    );
  }

  Widget addCurrency(BuildContext context) {
    return AppScaffold(
      currentTab: "Currency",
      appBar: AppBar(
        title: const Text("Add currency"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Currency code',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter currency code.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        code = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Currency name',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _curencyName = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Symbol',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter currency symbol.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _symbol = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Rate',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter  currency rate.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        exchangeRate = double.parse(value!);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: saveForm,
                      child: const Text('Save'),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
