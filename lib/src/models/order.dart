import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

/// Order status
enum OrderStatus { confirmed, shipped, delivered }

/// Helper method to get the order status from String
extension OrderStatusString on OrderStatus {
  static OrderStatus fromString(String string) {
    return switch (string) {
      ('confirmed') => OrderStatus.confirmed,
      ('shipped') => OrderStatus.shipped,
      ('deliverd') => OrderStatus.delivered,
      _ => throw Exception('Could not parse order status: $string'.hardcoded),
    };
  }
}

/// * The order identifier is an important concept and can have its own type.
typedef OrderID = String;

/// Model class representing an order placed by the user.
class Order {
  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.orderStatus,
    required this.orderDate,
    required this.total,
  });

  /// Unique order ID
  final OrderID id;

  /// ID of the user who made the order
  final String userId;

  /// List of items in that order
  final Map<String, int> items;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final double total;
}
