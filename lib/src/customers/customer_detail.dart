
import 'package:bus_system/models/customer.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:bus_system/src/widgets/display_image_widget.dart';
import 'package:flutter/material.dart';

class CustomerDetailsPage extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsPage({Key? key, required this.customer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      currentTab: 'Customers',
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          InkWell(
              onTap: () {},
              child: DisplayImage(
                imagePath: 'assets/images/ProfileImage.jpg',
                onPressed: () {},
              )),
          buildUserInfoDisplay(customer.fullname, 'Name'),
          buildUserInfoDisplay(customer.phone, 'Phone'),
          buildUserInfoDisplay(customer.email, 'Email'),
          buildUserInfoDisplay(customer.address ?? ' ', 'Address'),
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Text(
                textAlign: TextAlign.left,
                getValue,
                style: const TextStyle(fontSize: 16, height: 1.4),
              )),
        ],
      ));

  // Widget builds the About Me Section
  Widget buildAbout(Customer customer) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {},
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  customer.fullname,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));
}

 

  // Widget builds the display item with the proper formatting to display the user's info
 

  // Refrshes the Page after updating user info.
  