import 'package:bus_system/models/currency.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';


class CurrencyDetails extends StatelessWidget {
  final Currency currency;
  const CurrencyDetails({Key? key, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: const Text("Currency details"),
        ),
        currentTab: "",
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 10,
              ),
              buildUserInfoDisplay(currency.code, "code"),
              buildUserInfoDisplay(currency.name, 'Phone'),
              buildUserInfoDisplay(currency.symbol, 'Email'),
              buildUserInfoDisplay(
                  currency.lastUpdate.toString() ?? ' ', 'Address'),
            ],
          ),
        ));
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

  Widget buildAbout(Currency currency) => Padding(
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
                                  currency.name,
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
