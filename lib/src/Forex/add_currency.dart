import 'package:bus_system/models/currency.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'currency_list.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({super.key});

  @override
  State<AddCurrency> createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  final _formKey = GlobalKey<FormState>();
  late String code;
  late String _curencyName;
  late String _symbol;
  late double exchangeRate;
  late DateTime lastUpdate;
  void _saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    final newCurrency = Currency(
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
      currentTab: "",
      appBar: AppBar(
        title: Text("Add currency"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter cuurency name.';
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
                    labelText: 'Name',
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
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a name.';
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
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    exchangeRate = value! as double;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    lastUpdate = value! as DateTime;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _saveForm,
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
