class CartItem {
  final int id;
  final String userId;
  final String productId;
  final String title;
  final String imagePath;
  final String price;
  final String description;
  final int quantity;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.description,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      productId: map['product_id'] as String,
      title: map['title'] as String,
      imagePath: map['image_path'] as String,
      price: map['price'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'title': title,
      'image_path': imagePath,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }
}
