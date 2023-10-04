import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  String? description;
  String? category;
  double? amount;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: const Text('Add service'),
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
                    name = value!;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    description = value!;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    description = value!;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Selling price',
                  ),
                  onSaved: (value) {
                    amount = double.tryParse(value!);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
        currentTab: "Services");
  }
}
