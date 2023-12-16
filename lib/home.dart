import 'dart:async';

import 'package:bus_system/auth/session_Managers.dart';
import 'package:bus_system/src/Forex/currency_list.dart';
import 'package:bus_system/src/customers/customerlist.dart';
import 'package:bus_system/src/notifications/notifications.dart';
import 'package:bus_system/src/payment_methods/method_list.dart';
import 'package:bus_system/src/reports/transaction_summary.dart';
import 'package:bus_system/src/routes/routes_page.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:bus_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

import 'src/ticketing/new_ticket.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

var products = [];

class _HomeState extends State<Home> {
  final FlexibleHeaderDelegate _headerDelegate = FlexibleHeaderDelegate();
  final StreamController<int> _notificationCountController =
      StreamController<int>();
  late Stream<int> _notificationCountStream;
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    _notificationCountStream = _notificationCountController.stream;
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          _isVisible = false;
        });
      } else if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          _isVisible = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _notificationCountController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: homeMobile(),
      currentTab: 'Home',
      defaultScrolling: false,
    );
  }

  Widget homeMobile() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        if (AppScaffold.isMobileDevice(context) ||
            AppScaffold.isTabletDevice(context)) {
          var notificationCountStream = Stream<int>.value(2);
          return <Widget>[
            Theme(
              data: ThemeData(
                primaryColor: Colors.transparent,
              ),
              child: SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: FlexibleHeaderDelegate(
                  statusBarHeight: MediaQuery.of(context).padding.top,
                  expandedHeight: 240,
                  background: MutableBackground(
                    collapsedColor: secondaryColor,
                    expandedWidget: Image.asset(
                      'assets/images/loginImage.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: StreamBuilder<int>(
                        stream: notificationCountStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          // show the notification icon with badge if there are unread notifications
                          if (snapshot.hasData && snapshot.data! > 0) {
                            return Stack(
                              children: [
                                const Icon(Icons.notifications),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      snapshot.data!.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          // show the default notification icon if there are no unread notifications
                          return const Icon(Icons.notifications_none);
                        },
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationsPage()),
                        );
                      },
                    ),
                  ],
                  children: [
                    Visibility(
                      visible: _isVisible,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 16.0,
                                bottom: 16.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    color: AppTheme.defaultTheme.cardColor,
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                Text(
                                  SessionManagers.currentUser!.name,
                                  style: TextStyle(
                                      color: AppTheme.defaultTheme.cardColor,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlexibleTextItem(
                      text: _isVisible
                          ? 'Tickets Sold Today : \n\$10000'
                          : 'Ticket Sold Today : \$10000 \n',
                      maxLines: 2,
                      collapsedStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                      expandedStyle: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                      expandedAlignment: Alignment.bottomLeft,
                      collapsedAlignment: Alignment.bottomCenter,
                      expandedPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ],
                ),
              ),
            )
          ];
        } else {
          return <Widget>[];
        }
      },
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Operations",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 0, right: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NewTicket()),
                                    );
                                    //await Navigator.pushNamed(context, '/sales');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 1.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          FeatherIcons.shoppingBag,
                                          size: 36.0,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          "New\nTicket",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const StockMovementTabController()),
                                    // );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          FeatherIcons.file,
                                          size: 36.0,
                                          color: primaryColor,
                                        ),
                                        Text("Ticket\nPrices",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.0,
                                            ),
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TranSummary()));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          FeatherIcons.fileText,
                                          size: 36.0,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          "Ticket\nReports",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CustomersPage()),
                                    );
                                    //await Navigator.pushNamed(context, '/sales');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 1.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          FeatherIcons.users,
                                          size: 36.0,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          "Customers",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RoutesPage()),
                                    );
                                    //await Navigator.pushNamed(context, '/sales');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 1.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.route,
                                          size: 36.0,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          "Routes",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CurrencyList()),
                                    );
                                    //await Navigator.pushNamed(context, '/sales');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 1.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          FeatherIcons.dollarSign,
                                          size: 36.0,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          "Currency",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MethodList()),
                                      );
                                      //await Navigator.pushNamed(context, '/sales');
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 1.0,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            FeatherIcons.refreshCcw,
                                            size: 36.0,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            "payment method",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12.0),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 64,
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    //   child: Text("Previous Parcel Recordings",
                    //       style: TextStyle(
                    //         fontSize: 16.0,
                    //         fontWeight: FontWeight.w400,
                    //       )),
                    // ),
                    // const Divider(height: 1, thickness: 1),
                    // ListView.builder(
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemCount: products.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ListTile(
                    //       leading: Container(
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: Colors.white,
                    //           border: Border.all(
                    //             color: Colors.black54,
                    //             width: 1.0,
                    //           ),
                    //         ),
                    //         child: Center(
                    //           child: Text(
                    //             '${index + 1}',
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ),
                    //         width: 50.0,
                    //         height: 50.0,
                    //       ),
                    //       title: Text(products[index].name),
                    //       subtitle: Text(products[index].brand!.toString()),
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Text("Previous Parcel Recordings",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const Divider(height: 1, thickness: 1),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black54,
                          width: 1.0,
                        ),
                      ),
                      width: 50.0,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(products[index].name),
                    subtitle: Text(products[index].brand!.toString()),
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
