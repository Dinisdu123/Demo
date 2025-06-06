class Product {
  final String id;
  final String name;
  final String imagePath;
  final String price;
  final String description;
  final String subCategory;

  Product({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
    required this.subCategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    if (id == null || id.isEmpty) {
      print('Warning: Missing or empty ID in JSON: $json');
    }
    return Product(
      id: id ?? 'unknown_${DateTime.now().millisecondsSinceEpoch}',
      name: json['name'] ?? json['title'] ?? 'Unknown',
      imagePath: json['image_path'] ??
          json['imagePath'] ??
          json['image_url'] ??
          json['thumbnail'] ??
          'assets/images/placeholder.jpg',
      price: json['price'] is num
          ? 'LKR ${json['price'].toStringAsFixed(2)}'
          : json['price'] ?? 'LKR 0.00',
      description: json['description'] ?? 'No description available',
      subCategory: json['sub_category'] ?? json['subCategory'] ?? 'unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_path': imagePath,
      'price': price,
      'description': description,
      'sub_category': subCategory,
    };
  }
}
