import 'package:bus_system/models/invoice_line.dart';
import 'package:bus_system/models/transport_service.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class TicketLinesPage extends StatefulWidget {
  List<InvoiceLine> invoiceLines = [];

  TicketLinesPage({Key? key, required this.invoiceLines}) : super(key: key);

  @override
  TicketLinesPageState createState() => TicketLinesPageState();
}

class TicketLinesPageState extends State<TicketLinesPage> {
  final TextEditingController _quantityController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (builder, context) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 1,
                  height: 1,
                )),
            itemCount: widget.invoiceLines.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(index.toString()),
                onDismissed: (direction) {
                  setState(() {
                    widget.invoiceLines.removeAt(index);
                  });
                },
                background: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    // display menu here
                    showPopupMenu(context, index);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.invoiceLines[index].service.name,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Price: \$${widget.invoiceLines[index].unitCost.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: labelText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(),
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
              SizedBox(
                width: 16.0,
              ),
              FloatingActionButton(
                onPressed: () {
                  // Perform checkout

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('New Payment'),
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'Total price: \$${totalPrice.toStringAsFixed(2)}'),
                                SizedBox(height: 8),
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
                                  decoration: InputDecoration(
                                    labelText: 'Tendered amount',
                                  ),
                                ),
                                SizedBox(height: 16),
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
                            child: Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              double tenderedAmount = double.tryParse(
                                      _tenderedAmountController.text) ??
                                  0.0;
                              _change = tenderedAmount - totalPrice;
                              // savetransaction(widget.products, _quantities,
                              //     totalPrice, tenderedAmount, _change);
                              setState(() {});
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.shopping_cart),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showPopupMenu(BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Darkened background
            Container(
              color: Colors.black54,
              width: double.infinity,
              height: double.infinity,
            ),
            // Menu
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  color: primaryColor,
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Product Options : ${widget.invoiceLines[index].service.name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const PopupMenuItem(
                          value: "edit",
                          child: Text(
                            "Edit Quantity",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuItem(
                          value: "remove",
                          child: Text(
                            "Remove Product",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuItem(
                          value: "details",
                          child: Text(
                            "View Details",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      switch (value) {
        case "edit":
          _editQuantity(index);
          break;
        case "remove":
          _removeProduct(index);
          break;
        case "details":
          break;
      }
    });
  }

  void _editQuantity(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Quantity'),
          content: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter Quantity'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                _quantityController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  //_quantities[index] = int.parse(_quantityController.text);
                });
                _quantityController.clear();
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
