import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/product.dart';

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final String category;
  ProductNotifier(this.category) : super(const AsyncValue.loading()) {
    fetchProducts();
  }

  Future<bool> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> fetchProducts() async {
    final isConnected = await _checkConnectivity();
    print('Connectivity: $isConnected for category: $category');

    if (isConnected) {
      try {
        final products = await _fetchFromApi(category);
        print(
            'API Products ($category): ${products.map((p) => 'id=${p.id}, name=${p.name}').toList()}');
        state = AsyncValue.data(products);
        await _saveToLocal(products);
        return;
      } catch (e) {
        print('API Error for $category: $e');
        try {
          final products = await _fetchFromExternalJson(category);
          print(
              'External JSON Products ($category): ${products.map((p) => 'id=${p.id}, name=${p.name}').toList()}');
          state = AsyncValue.data(products);
          await _saveToLocal(products);
          return;
        } catch (e) {
          print('External JSON Error for $category: $e');
        }
      }
    }

    try {
      final products = await _loadLocalJsonFromAssets(category);
      print(
          'Local JSON (Assets) Products ($category): ${products.map((p) => 'id=${p.id}, name=${p.name}').toList()}');
      state = AsyncValue.data(products);
      return;
    } catch (e) {
      print('Local JSON (Assets) Error for $category: $e');
      try {
        final products = await _loadLocalJsonFromDocuments(category);
        print(
            'Local JSON (Documents) Products ($category): ${products.map((p) => 'id=${p.id}, name=${p.name}').toList()}');
        state = AsyncValue.data(products);
        return;
      } catch (e) {
        print('Local JSON (Documents) Error for $category: $e');
        final localProducts = await loadFromLocal(category);
        print(
            'Local Storage Products ($category): ${localProducts.map((p) => 'id=${p.id}, name=${p.name}').toList()}');
        if (localProducts.isNotEmpty) {
          state = AsyncValue.data(localProducts);
        } else {
          state = AsyncValue.error(
              Exception('No products available offline'), StackTrace.current);
        }
      }
    }
  }

  Future<List<Product>> _fetchFromApi(String category) async {
    String endpoint;
    switch (category.toLowerCase()) {
      case 'fragrance':
        endpoint = 'fragrances';
        break;
      case 'leather-goods':
        endpoint = 'leather-goods';
        break;
      case 'accessories':
        endpoint = 'accessories';
        break;
      default:
        throw Exception('Unsupported category: $category');
    }
    final response = await http
        .get(Uri.parse(
            'https://darkorange-goldfinch-978675.hostingersite.com/api/products/$endpoint'))
        .timeout(const Duration(seconds: 10));
    print('API Response for $category: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Product> products = [];
      int index = 0;
      data.forEach((subCat, items) {
        if (items is List) {
          products.addAll(items.map((json) {
            final product = Product.fromJson({
              ...json,
              'id': json['id']?.toString() ?? '${category}_api_${index++}',
              'sub_category': subCat,
              'image_path':
                  json['image_url'] ?? 'assets/images/placeholder.jpg',
            });
            return product;
          }));
        }
      });
      return products;
    } else {
      throw Exception(
          'Failed to load products from API: ${response.statusCode}');
    }
  }

  Future<List<Product>> _fetchFromExternalJson(String category) async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products/category/$category'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> products = data['products'] ?? [];
      int index = 0;
      return products
          .map((json) => Product(
                id: json['id']?.toString() ?? '${category}_external_${index++}',
                name: json['title'] ?? 'Unknown',
                imagePath: json['thumbnail'] ?? 'assets/images/placeholder.jpg',
                price: 'LKR ${(json['price'] * 300).toStringAsFixed(2)}',
                description: json['description'] ?? 'No description available',
                subCategory: json['category'] ?? 'unknown',
              ))
          .toList();
    } else {
      throw Exception('Failed to load external JSON: ${response.statusCode}');
    }
  }

  Future<List<Product>> _loadLocalJsonFromDocuments(String category) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data/$category.json');
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        print('Local JSON (Documents) Content for $category: $jsonString');
        final List<dynamic> data = jsonDecode(jsonString);
        int index = 0;
        return data
            .map((json) => Product.fromJson({
                  ...json,
                  'id': json['id']?.toString() ?? '${category}_doc_${index++}',
                }))
            .toList();
      }
      throw Exception('No local JSON file found in documents directory');
    } catch (e) {
      print('Error loading local JSON from documents for $category: $e');
      rethrow;
    }
  }

  Future<List<Product>> _loadLocalJsonFromAssets(String category) async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/$category.json');
      print('Local JSON (Assets) Content for $category: $jsonString');
      final List<dynamic> data = jsonDecode(jsonString);
      int index = 0;
      return data
          .map((json) => Product.fromJson({
                ...json,
                'id': json['id']?.toString() ?? '${category}_asset_${index++}',
              }))
          .toList();
    } catch (e) {
      print('Error loading local JSON from assets for $category: $e');
      rethrow;
    }
  }

  Future<void> _saveToLocal(List<Product> products) async {
    try {
      final modifiedProducts = products.map((p) {
        return Product(
          id: p.id,
          name: p.name,
          imagePath: p.imagePath.startsWith('http')
              ? 'assets/images/placeholder.jpg'
              : p.imagePath,
          price: p.price,
          description: p.description,
          subCategory: p.subCategory,
        );
      }).toList();
      final prefs = await SharedPreferences.getInstance();
      final jsonString =
          jsonEncode(modifiedProducts.map((p) => p.toJson()).toList());
      await prefs.setString('$category-products', jsonString);

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data/$category.json');
      final fileDir = Directory('${directory.path}/data');
      if (!await fileDir.exists()) {
        await fileDir.create(recursive: true);
      }
      await file.writeAsString(jsonString);
      print('Saved products to local storage for $category');
    } catch (e) {
      print('Error saving to local storage: $e');
    }
  }

  Future<List<Product>> loadFromLocal(String category) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('$category-products');
      if (jsonString != null) {
        final List<dynamic> data = jsonDecode(jsonString);
        int index = 0;
        return data
            .map((json) => Product.fromJson({
                  ...json,
                  'id':
                      json['id']?.toString() ?? '${category}_local_${index++}',
                }))
            .toList();
      }
      return await _loadLocalJsonFromDocuments(category);
    } catch (e) {
      print('Error loading from local storage for $category: $e');
      return [];
    }
  }
}

final productProvider = StateNotifierProvider.family<ProductNotifier,
    AsyncValue<List<Product>>, String>((ref, category) {
  return ProductNotifier(category);
});
