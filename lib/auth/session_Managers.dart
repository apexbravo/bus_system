import 'dart:convert';
import 'package:bus_system/models/user.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class SessionManagers {
  static User? _currentUser;
  static User? get currentUser => _currentUser;

  static Future<void> signIn(User user) async {
    _currentUser = user;
    DateTime tokenExpiry = DateTime.now().add(const Duration(hours: 1));
    user.tokenExpiryDate = tokenExpiry;
    await SessionManager().set('currentUser', const JsonEncoder().convert(user));
    print(user.toJson());
  }

  static Future<void> clear() async {
    _currentUser = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
  }

  static bool get isAuthenticated {
    if (_currentUser == null) return false;
    var testing = currentUser!.tokenExpiryDate!.isAfter(DateTime.now());
    return currentUser!.tokenExpiryDate!.isAfter(DateTime.now());
  }

  static Future<void> signOut(BuildContext context) async {
    await clear();
    if (currentUser != null) {
      currentUser!.tokenExpiryDate =
          DateTime.now().subtract(const Duration(hours: 1));
    }
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Add a method to initialize the SessionManager from shared preferences during app startup
  static Future<void> initialize() async {
    var currentUserJson = await SessionManager().get('currentUser');
    print(currentUserJson);
    if (currentUserJson != null) {
      _currentUser = User.fromJson(Map<String, dynamic>.from(currentUserJson));
    }
  }

  static bool loggedInBefore() =>
      currentUser != null &&
      currentUser!.tokenExpiryDate!.millisecondsSinceEpoch >
          DateTime.now().add(const Duration(days: -1)).millisecondsSinceEpoch;
}
