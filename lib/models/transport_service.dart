import 'package:bus_system/models/item_size.dart';
import 'package:bus_system/models/price.dart';

class TransportService {
  String id;
  String name;
  String? description;
  String? category;
  Price? price;

  TransportService({
    required this.id,
    required this.name,
    this.category,
    this.description,
    this.price,
  });
}
