import 'package:bus_system/models/customer.dart';
import 'package:bus_system/src/customers/customer_add.dart';
import 'package:bus_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../widgets/app_scaffold.dart';
import 'customer_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: "/Customers",
      pageTitle: "Customers",
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All Customers',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('customers')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final List<Customer> customers = snapshot.data!.docs
                    .map((doc) => Customer.fromJson(doc.data()))
                    .toList();

                return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final customer = customers[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomerDetailsPage(customer: customer),
                          ),
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      title: Text(customer.fullname ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(customer.phone ?? ''),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCustomerPage(),
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
