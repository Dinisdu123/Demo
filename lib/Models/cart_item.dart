class CartItem {
  final int? id;
  final String userId;
  final String productId;
  final String title;
  final String imagePath;
  final String price;
  final String description;
  final int quantity;

  CartItem({
    this.id,
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
      id: map['id'],
      userId: map['user_id'],
      productId: map['product_id'],
      title: map['title'],
      imagePath: map['image_path'],
      price: map['price'],
      description: map['description'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
