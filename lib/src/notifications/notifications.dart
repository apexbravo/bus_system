import 'package:bus_system/models/enums/importance_level.dart';
import 'package:bus_system/models/notifications.dart';
import 'package:bus_system/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationData> notifications = [
    NotificationData(
      message: "You have a new message!",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      importanceLevel: ImportanceLevel.medium,
      isRead: false,
    ),
    NotificationData(
      message: "Your order has been shipped!",
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      importanceLevel: ImportanceLevel.low,
      isRead: true,
    ),
    NotificationData(
      message: "Don't forget to complete your profile!",
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      importanceLevel: ImportanceLevel.high,
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: 'Notifications',
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index].message),
            subtitle: Text(
              _formatTimestamp(notifications[index].timestamp),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                      _getGradientColors(notifications[index].importanceLevel),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                notifications[index].importanceLevel.toString().split('.').last,
                style: TextStyle(
                  color: _getColorforText(notifications[index].importanceLevel),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference.inMinutes < 1) {
      return "just now";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago";
    } else if (difference.inDays < 1) {
      return "${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago";
    } else {
      return "${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago";
    }
  }

  _getColorforText(ImportanceLevel importanceLevel) {
    switch (importanceLevel) {
      case ImportanceLevel.low:
        return Colors.black;
      case ImportanceLevel.medium:
        return Colors.black;
      case ImportanceLevel.high:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  List<Color> _getGradientColors(ImportanceLevel level) {
    switch (level) {
      case ImportanceLevel.low:
        return [
          const Color(0xFF24C0EB),
          const Color(0xFF90F7EC),
        ];
      case ImportanceLevel.medium:
        return [
          const Color(0xFFFFD119),
          const Color(0xFFFFB140),
        ];
      case ImportanceLevel.high:
        return [
          const Color(0xFFFF4D4D),
          const Color(0xFFBE2323),
        ];
      default:
        return [
          Colors.grey,
          Colors.grey,
        ];
    }
  }
}
