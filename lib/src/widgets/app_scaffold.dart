import 'dart:developer';

import 'package:bus_system/auth/session_Managers.dart';
import 'package:bus_system/src/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
FirebaseFirestore FirebaseDb = FirebaseFirestore.instance;

class AppScaffold extends StatefulWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final String currentTab;
  final String? pageTitle;
  final bool showDrawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? actions;

  const AppScaffold(
      {super.key,
      required this.body,
      this.appBar,
      this.floatingActionButton,
      this.showDrawer = false,
      required this.currentTab,
      this.pageTitle,
      this.floatingActionButtonLocation,
      this.actions});

  static bool isMobileDevice(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTabletDevice(BuildContext context) =>
      MediaQuery.of(context).size.width > 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktopDevice(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static bool isLoggedIn = false;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    if (SessionManagers.isAuthenticated) {
      log("User not authenticated. Redirecting to login page");
      return const LoginPage();
    }
    bool isMobile = AppScaffold.isMobileDevice(context);
    return Scaffold(
      body: widget.body,

      appBar: isMobile ? widget.appBar : null,
      floatingActionButton: isMobile ? widget.floatingActionButton : null,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: isMobile || AppScaffold.isTabletDevice(context)
      //     ? AppBottomNav(
      //         currentTab: widget.currentTab,
      //       )
      //     : null,
    );
  }
}
