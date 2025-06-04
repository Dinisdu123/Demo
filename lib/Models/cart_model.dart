import 'dart:convert';

class CartItem {
  final int id;
  final int userId;
  final int productId;
  final int quantity;
  final double totalPrice;
  final Product product;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      totalPrice: double.parse(json['total_price'].toString()),
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'total_price': totalPrice,
      'product': product.toJson(),
    };
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
    };
  }
}
