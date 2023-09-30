import 'package:uuid/uuid.dart';

class Guid {
  static String newId() {
    var uuid = const Uuid();
    return uuid.v1();
  }
}
