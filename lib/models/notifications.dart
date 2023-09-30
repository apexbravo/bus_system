import 'package:bus_system/models/enums/importance_level.dart';

class NotificationData {
  final String message;
  final DateTime timestamp;
  final ImportanceLevel importanceLevel;
  final bool isRead;

  NotificationData({
    required this.message,
    required this.timestamp,
    required this.importanceLevel,
    required this.isRead,
  });
}
