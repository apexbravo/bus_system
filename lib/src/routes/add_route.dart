import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/db.dart';
import '../../theme/app_theme.dart';

class AddRoute extends StatefulWidget {
  const AddRoute({super.key});

  @override
  State<AddRoute> createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final routeController = TextEditingController();
  final mb = 24.0;
  final mbLabel = 8.0;
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
              floatingLabelStyle: TextStyle(color: secondaryColor),
              fillColor: Colors.transparent,
              filled: true,
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
      currentTab: "Routes",
      appBar: AppBar(
        title: const Text("Add Route"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pick a route",
              style: textStyle,
            ),
            SizedBox(
              height: mbLabel,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: routeController,
                    readOnly: true,
                  ),
                ),
                SizedBox(
                  width: 75,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 241, 240, 240),
                    radius: 26,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        icon: const Icon(Icons.swap_horiz),
                        onPressed: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: mb,
            ),
            formTypeAheadGroup("From (Point A)", fromController),
            SizedBox(
              height: mb,
            ),
            formTypeAheadGroup("To (Point B)", toController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRoute(),
            ),
          );
        },
        child: const Icon(
          FeatherIcons.save,
          color: Colors.white,
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
