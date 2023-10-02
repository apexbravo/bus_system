import 'package:bus_system/models/customer.dart';
import 'package:bus_system/src/customers/customerlist.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({Key? key}) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _avatarUrl;
  late String _email;
  late String _phone;
  late String _address;

  void _saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    final newCustomer = Customer(
      fullname: _name,
      avatarUrl: _avatarUrl,
      email: _email,
      phone: _phone,
      address: _address,
    );
    // Convert the Customer object to a map
    final customerMap = newCustomer.toJson();
// Add the customer data to the "users" collection in Firestore
    FirebaseFirestore.instance
        .collection("customers")
        .add(customerMap)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'))
        .catchError((error) => print('Error adding customer: $error'));

    // You can now do something with the newCustomer object, like adding it to a list or storing it in a database.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomersPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: 'Customers',
      pageTitle: "Add Customer",
      appBar: AppBar(
        title: const Text('Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  _name = value!;
                },
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Avatar URL',
                ),
                validator: (value) {
                  // You could add more validation here if needed.
                  return null;
                },
                onSaved: (value) {
                  _avatarUrl = value ?? '';
                },
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter an email address.';
                  }
                  if (!value!.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a phone number.';
                  }
                  // You could add more validation here if needed.
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter adress.';
                  }
                  // You could add more validation here if needed.
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
