import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:bus_system/theme/app_theme.dart';

class TranSummary extends StatefulWidget {
  const TranSummary({super.key});

  @override
  State<TranSummary> createState() => _TranSummaryState();
}

class _TranSummaryState extends State<TranSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.defaultTheme.cardColor,
      resizeToAvoidBottomInset: false,
      body: repMobile(context),
    );
  }

  Widget repMobile(BuildContext context) {
    return AppScaffold(
      currentTab: "",
      appBar: AppBar(title: const Text("Transactions")),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Expanded(
                  child: DataTableTheme(
                      data: DataTableThemeData(
                        dataRowColor: MaterialStateProperty.resolveWith(
                            (states) => accentCircleColor),
                        headingRowHeight: 40.0,
                      ),
                      child: DataTable(
                          headingTextStyle: const TextStyle(
                              color: textColorPrimary,
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => accentCircleColor),
                          showCheckboxColumn: false,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Parcel number",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    "Parcel",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Customer",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    "Beneficiary",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                            DataColumn(
                              label: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    "Payment method",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            ),
                          ],
                          rows: const [
                            DataRow(
                              cells: [
                                DataCell(
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [Text("PL02178"), Text("Bed")],
                                  ),
                                ),
                                DataCell(
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [Text("Anesu"), Text("Abel")],
                                  ),
                                ),
                                DataCell(
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text("USD"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("20.00")
                                        ],
                                      ),
                                      Text("Cash")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
