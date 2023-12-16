import 'package:bus_system/models/Userrights.dart';
import 'package:bus_system/models/customer.dart';
import 'package:bus_system/models/db.dart';
import 'package:bus_system/models/enums/invoice_status.dart';
import 'package:bus_system/models/invoice.dart';
import 'package:bus_system/models/invoice_line.dart';
import 'package:bus_system/models/payment_method.dart';
import 'package:bus_system/models/role.dart';
import 'package:bus_system/models/user.dart';
import 'package:bus_system/src/receipting/transactions/invoice_page.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../models/currency.dart';
import '../../../theme/app_theme.dart';
import '../../customers/customer_add.dart';
import '../../helper.dart';

class TicketLinesPage extends StatefulWidget {
  List<InvoiceLine> invoiceLines = [];

  TicketLinesPage({Key? key, required this.invoiceLines}) : super(key: key);

  @override
  TicketLinesPageState createState() => TicketLinesPageState();
}

class TicketLinesPageState extends State<TicketLinesPage> {
  final TextEditingController costController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController _tenderedAmountController =
      TextEditingController();
  double _change = 0.0;

  double get totalPrice {
    double total = 0.0;
    for (var item in widget.invoiceLines) {
      total += item.quantity * item.unitCost;
    }
    return total;
  }

  var btnTextStyle = const TextStyle(
    fontSize: 16,
  );
  Currency currency = Db.currencies.first;
  PaymentMethod? paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Currency'),
                  SizedBox(
                    width: 175,
                    child: DropdownSearch<Currency>(
                      dropdownButtonProps: const DropdownButtonProps(
                          padding: EdgeInsets.all(
                        14,
                      )),
                      popupProps: const PopupProps.menu(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                        menuProps: MenuProps(
                          backgroundColor: Colors.white,
                          elevation: 2,
                        ),
                      ),
                      items: Db.currencies,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 18,
                          ),
                          fillColor: Colors.transparent,
                        ),
                      ),
                      selectedItem: currency,
                      itemAsString: (item) => item.id,
                      compareFn: (item1, item2) {
                        if (item1.id == item2.id) return true;
                        return false;
                      },
                      onChanged: (value) => setState(() {
                        //currency = value!;
                      }),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Payment method'),
                  SizedBox(
                    width: 175,
                    child: DropdownSearch<PaymentMethod>(
                      dropdownButtonProps: const DropdownButtonProps(
                          padding: EdgeInsets.all(
                        14,
                      )),
                      popupProps: const PopupProps.menu(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                        menuProps: MenuProps(
                          backgroundColor: Colors.white,
                          elevation: 2,
                        ),
                      ),
                      items: Db.paymentMethods,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 18,
                          ),
                          fillColor: Colors.transparent,
                        ),
                      ),
                      selectedItem: paymentMethod,
                      itemAsString: (item) => item.name,
                      compareFn: (item1, item2) {
                        if (item1.id == item2.id) return true;
                        return false;
                      },
                      onChanged: (value) => setState(() {
                        paymentMethod = value!;
                      }),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Customer'),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownSearch<Currency>(
                          dropdownButtonProps: const DropdownButtonProps(
                              padding: EdgeInsets.all(
                            14,
                          )),
                          popupProps: const PopupProps.menu(
                            fit: FlexFit.loose,
                            showSelectedItems: true,
                            menuProps: MenuProps(
                              backgroundColor: Colors.white,
                              elevation: 2,
                            ),
                          ),
                          items: const [],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                              fillColor: Colors.transparent,
                            ),
                          ),
                          selectedItem: null,
                          itemAsString: (item) => item.id,
                          compareFn: (item1, item2) {
                            if (item1.id == item2.id) return true;
                            return false;
                          },
                          onChanged: (value) => setState(() {
                            //currency = value!;
                          }),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddCustomerPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: Text("Add", style: btnTextStyle),
                          style: AppTheme.tertiaryBtnStyle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("Ticket items"),
        ),
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0,
            ),
            child: ListView.separated(
              separatorBuilder: (builder, context) => const Divider(
                thickness: 1,
                height: 1,
              ),
              itemCount: widget.invoiceLines.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    editLinePopup(index);
                  },
                  leading: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.invoiceLines.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                  title: Text(
                    widget.invoiceLines[index].service.name,
                  ),
                  subtitle: Text(
                    '${widget.invoiceLines[index].service.category ?? ""} ${widget.invoiceLines[index].service.category != null && widget.invoiceLines[index].description != null ? "-" : ""} ${widget.invoiceLines[index].description ?? ""}',
                  ),
                  trailing: Text(
                    toMoney(widget.invoiceLines[index].unitCost, currency),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: labelText,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("TOTAL",
                        style: Theme.of(context).textTheme.titleMedium),
                    Text("USD. ${totalPrice.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              FloatingActionButton(
                onPressed: () {
                  // Perform checkout

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('New Payment'),
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'Total price: \$${totalPrice.toStringAsFixed(2)}'),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _tenderedAmountController,
                                  onChanged: (value) {
                                    double tenderedAmount =
                                        double.tryParse(value) ?? 0.0;
                                    setState(() {
                                      _change = tenderedAmount - totalPrice;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Tendered amount',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Change: \$${_change.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: _change >= 0
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        actions: [
                          TextButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              double tenderedAmount = double.tryParse(
                                      _tenderedAmountController.text) ??
                                  0.0;
                              _change = tenderedAmount - totalPrice;
                              // savetransaction(widget.products, _quantities,
                              //     totalPrice, tenderedAmount, _change);
                              setState(() {
                                var invoice = Invoice(
                                    creationDate: DateTime.now(),
                                    number: "INV1002",
                                    creator: User(
                                        name: "Daniel",
                                        initials: "initials",
                                        email: "d@gmail.com",
                                        userRole: Role("name", <UserRights>{})),
                                    lines: widget.invoiceLines,
                                    status: InvoiceStatus.settled,
                                    amountTendered: double.parse(
                                        _tenderedAmountController.text),
                                    customer: Customer(
                                        fullname: "Peter Tej",
                                        email: "ptej@gmail.com",
                                        phone: "0775676543"),
                                    currency: currency);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InvoicePage(
                                      invoice: invoice,
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.shopping_cart),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void editLinePopup(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Line'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: costController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText:
                      widget.invoiceLines[index].unitCost.toStringAsFixed(2),
                  label: const Text("Cost"),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: widget.invoiceLines[index].description ?? "",
                  label: const Text("Description"),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                costController.clear();
                descriptionController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  widget.invoiceLines[index].description =
                      descriptionController.text == ""
                          ? null
                          : descriptionController.text;
                  widget.invoiceLines[index].unitCost =
                      double.tryParse(costController.text) != null
                          ? double.parse(costController.text)
                          : widget.invoiceLines[index].unitCost;
                });
                descriptionController.clear();
                costController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeProduct(int index) {
    setState(() {
      widget.invoiceLines.removeAt(index);
    });
  }
}
