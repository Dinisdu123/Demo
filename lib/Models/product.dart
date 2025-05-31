class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String description;
  final String subCategory;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.subCategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['title'] ?? 'Unknown',
      imageUrl:
          json['image_url'] ?? json['imageUrl'] ?? '', // Handle variations
      price: json['price'] is num
          ? 'LKR ${json['price'].toStringAsFixed(2)}'
          : json['price'] ?? 'LKR 0.00',
      description: json['description'] ?? '',
      subCategory: json['sub_category'] ?? json['subCategory'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'price': price,
      'description': description,
      'sub_category': subCategory,
    };
  }
}
