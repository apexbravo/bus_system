import 'package:bus_system/src/helper.dart';
import 'package:bus_system/src/receipting/new_ticket/ticket_lines_page.dart';
import 'package:bus_system/src/widgets/service_list.dart';
import 'package:flutter/material.dart';

import '../../../models/invoice_line.dart';
import '../../widgets/app_scaffold.dart';

class NewTicketTabController extends StatefulWidget {
  const NewTicketTabController({Key? key});

  @override
  State<NewTicketTabController> createState() => _NewTicketTabControllerState();
}

class _NewTicketTabControllerState extends State<NewTicketTabController>
    with SingleTickerProviderStateMixin {
  final GlobalKey<TicketLinesPageState> _checkoutPageKey =
      GlobalKey<TicketLinesPageState>();
  late TabController _tabController;

  List<InvoiceLine> invoiceLines = [];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Define the number of tabs
    _tabController.addListener(
        _handleTabSelection); // Add a listener to handle tab selection
  }

  void _handleTabSelection() {
    setState(() {}); // Rebuild the widget when the tab selection changes
  }

  void updateSelectedProducts(List<InvoiceLine> invoiceLines) {
    //_checkoutPageKey.currentState?.updateSelectedProducts(selectedProducts);
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose the controller when the widget is removed from the tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AppScaffold(
        currentTab: "New Sale",
        pageTitle: "New Sale",
        appBar: AppBar(
          title: const Text("New sale"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "CHECKOUT",
              ),
              Tab(
                text: "SELECT PRODUCTS",
              ),
            ],
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return TabBarView(
            controller: _tabController,
            children: [
              TicketLinesPage(
                key: _checkoutPageKey,
                invoiceLines: invoiceLines,
              ),
              ServiceList(
                onTap: (value) {
                  var pLine = InvoiceLine(
                    service: value,
                    quantity: 1,
                    unitCost: value.price?.amount ?? 0,
                  );
                  setState(() {
                    var found = false;
                    for (var element in invoiceLines) {
                      if (element.service.id == value.id) {
                        found = true;
                        break;
                      }
                    }

                    if (!found) {
                      invoiceLines.add(pLine);
                    }
                  });
                },
              ),
            ],
          );
        }),
        floatingActionButton: _tabController.index != 0
            ? FloatingActionButton(
                child: Icon(Icons.check_circle),
                onPressed: () {
                  setState(() {
                    _tabController.index = 0;
                  });
                },
              )
            : null,
      ),
    );
  }
}
