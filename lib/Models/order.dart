import 'dart:convert';

class Order {
  final int? id; // Auto-incremented by SQLite
  final String userId;
  final String name;
  final String phone;
  final String address;
  final List<OrderItem> items;
  final double total;
  final DateTime timestamp;
  final String paymentMethod; // New field
  final String? receiptImagePath; // New field, nullable

  Order({
    this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.items,
    required this.total,
    required this.timestamp,
    required this.paymentMethod,
    this.receiptImagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'address': address,
      'items': jsonEncode(items.map((item) => item.toMap()).toList()),
      'total': total,
      'timestamp': timestamp.toIso8601String(),
      'payment_method': paymentMethod,
      'receipt_image_path': receiptImagePath,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      items: (jsonDecode(map['items']) as List)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
      total: map['total'],
      timestamp: DateTime.parse(map['timestamp']),
      paymentMethod: map['payment_method'],
      receiptImagePath: map['receipt_image_path'],
    );
  }
}

class OrderItem {
  final String productId;
  final String title;
  final String imagePath;
  final String price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'title': title,
      'image_path': imagePath,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['product_id'],
      title: map['title'],
      imagePath: map['image_path'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
