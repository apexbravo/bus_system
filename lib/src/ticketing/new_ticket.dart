import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/db.dart';
import '../../theme/app_theme.dart';

class NewTicket extends StatefulWidget {
  const NewTicket({super.key});

  @override
  State<NewTicket> createState() => _NewTicketState();
}

class _NewTicketState extends State<NewTicket> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final _amountController = TextEditingController();
  final mb = 24.0;
  final mbLabel = 8.0;
  final cardPaddingX = 16.0;
  final cardPaddingY = 8.0;
  final cardPadding = 16.0;
  final textStyle = const TextStyle(fontWeight: FontWeight.bold);

  Widget formTypeAheadGroup(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textStyle,
        ),
        SizedBox(
          height: mbLabel,
        ),
        TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
            ),
          ),
          suggestionsCallback: (pattern) async {
            // Replace this with your logic to fetch available categories from added products
            return await getAvailableRoutes(pattern);
          },
          itemBuilder: (context, String suggestion) {
            return ListTile(
              title: Text(
                suggestion,
              ),
            );
          },
          noItemsFoundBuilder: (context) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'No suggestions found',
                //style: TextStyle(color: colorWindowBackground),
              ),
            );
          },
          onSuggestionSelected: (String suggestion) {
            setState(() {
              fromController.text = suggestion;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: "Tickets",
      appBar: AppBar(
        title: const Text(
          "New Ticket",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Text(
                    "Total To Pay",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$15.00",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: cardPaddingX, vertical: cardPaddingY),
                child: Column(
                  children: [
                    formTypeAheadGroup("From", fromController),
                    const SizedBox(
                      height: 8,
                    ),
                    formTypeAheadGroup("To", toController),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mb,
            ),
            Row(
              children: [
                Text(
                  "Bus fare",
                  style: textStyle,
                ),
                const Icon(Icons.money_outlined),
              ],
            ),
            Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'Amount',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        items: const [
                          DropdownMenuItem(child: Text("USD")),
                        ],
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 17,
                            horizontal: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mb,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  )),
                  backgroundColor: MaterialStatePropertyAll(primaryColor),
                ),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Add Parcel'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Description"),
                        TextFormField(),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Size"),
                        DropdownButtonFormField(
                          items: const [
                            DropdownMenuItem(child: Text("Large")),
                          ],
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Amount"),
                        TextFormField(),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FeatherIcons.shoppingBag,
                      color: Colors.white, // Set the icon color
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Add parcel',
                      style:
                          TextStyle(color: Colors.white), // Set the text color
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mb,
            ),
            const ListTile(
              title: Text("Door frames"),
              subtitle: Text("Medium"),
              trailing: Text("\$4.00"),
              tileColor: Colors.white,
            ),
            const ListTile(
              title: Text("Bed Queen size"),
              subtitle: Text("Medium"),
              trailing: Text("\$4.00"),
              tileColor: Colors.white,
            ),
            SizedBox(
              height: mb,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(buttonPrimary),
              ),
              onPressed: () {},
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }

  Future<List<String>> getAvailableRoutes(String pattern) async {
    List<String> availableCategories = [];
    List<String> brands = [];
    for (var item in Db.routes) {
      brands.contains(item.pointA) ? null : brands.add(item.pointA);
      brands.contains(item.pointB) ? null : brands.add(item.pointB);
    }
    for (var item in Db.subRoutes) {
      brands.contains(item.pointA) ? null : brands.add(item.pointA);
      brands.contains(item.pointB) ? null : brands.add(item.pointB);
    }
    // Check for partial category matches
    for (var item in brands) {
      if (item.toLowerCase().contains(pattern.toLowerCase()) &&
          pattern.isNotEmpty) {
        availableCategories.add(item);
      }
    }

    // Remove duplicate categories
    availableCategories = availableCategories.toSet().toList();

    return availableCategories;
  }
}
