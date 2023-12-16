import 'package:bus_system/models/payment_method.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../theme/app_theme.dart';
import 'add_method.dart';
import 'method_details.dart';

class MethodList extends StatefulWidget {
  const MethodList({super.key});

  @override
  State<MethodList> createState() => _MethodListState();
}

class _MethodListState extends State<MethodList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: methodList(context),
    );
  }

  Widget methodList(BuildContext context) {
    return AppScaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddMethod(),
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
          title: const Text("Payment methods"),
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
                    .collection('methods')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final List<PaymentMethod> methods = snapshot.data!.docs
                      .map((doc) => PaymentMethod.fromJson(doc.data()))
                      .toList();

                  return ListView.builder(
                    itemCount: methods.length,
                    itemBuilder: (BuildContext context, int index) {
                      final method = methods[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MethodDetails(),
                            ),
                          );
                        },
                        leading: const Text(""),
                        title: Text(method.name ?? ''),
                        subtitle: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(method.name ?? ''),
                              ],
                            ),
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
