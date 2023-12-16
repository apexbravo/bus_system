import 'package:bus_system/models/payment_method.dart';
import 'package:bus_system/src/payment_methods/method_list.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AddMethod extends StatefulWidget {
  const AddMethod({super.key});

  @override
  State<AddMethod> createState() => _AddMethodState();
}

class _AddMethodState extends State<AddMethod> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late int id;
  late bool paymentRef;

  void saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    final newmethod = PaymentMethod(
      name: name,
      requireRef: paymentRef,
      id: id,
    );
    // Convert the Customer object to a map
    final methodMap = newmethod.toJson();
// Add the customer data to the "users" collection in Firestore
    FirebaseFirestore.instance
        .collection("methods")
        .add(methodMap)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'))
        .catchError((error) => print('Error adding method: $error'));

    // You can now do something with the newCustomer object, like adding it to a list or storing it in a database.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MethodList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: addMethod(context),
    );
  }

  Widget addMethod(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("Add payment method"),
      ),
      currentTab: "",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: const BoxDecoration(),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'payment method',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter method name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value!;
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
