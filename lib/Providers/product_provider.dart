import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
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
        print('API Products: $products');
        state = AsyncValue.data(products);
        _saveToLocal(products);
        return;
      } catch (e) {
        print('API Error: $e');
        try {
          final products = await _fetchFromExternalJson(category);
          print('External JSON Products: $products');
          state = AsyncValue.data(products);
          _saveToLocal(products);
          return;
        } catch (e) {
          print('External JSON Error: $e');
        }
      }
    }

    try {
      final products = await _loadLocalJson(category);
      print('Local JSON Products: $products');
      state = AsyncValue.data(products);
      _saveToLocal(products);
    } catch (e) {
      print('Local JSON Error: $e');
      final localProducts = await loadFromLocal(category);
      print('Local Storage Products: $localProducts');
      if (localProducts.isNotEmpty) {
        state = AsyncValue.data(localProducts);
      } else {
        state = AsyncValue.error(e, StackTrace.current);
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
        throw Exception('Unsupported category');
    }
    final response = await http
        .get(Uri.parse(
            'https://darkorange-goldfinch-978675.hostingersite.com/api/products/$endpoint'))
        .timeout(const Duration(seconds: 10));
    print('API Response for $category: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Product> products = [];
      data.forEach((subCat, items) {
        if (items is List) {
          products.addAll(items.map((json) => Product.fromJson({
                ...json,
                'sub_category': subCat,
              })));
        }
      });
      return products;
    } else {
      throw Exception('Failed to load products from API: ${response.body}');
    }
  }

  Future<List<Product>> _fetchFromExternalJson(String category) async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products/category/$category'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> products = data['products'] ?? [];
      return products
          .map((json) => Product(
                id: json['id'].toString(),
                name: json['title'] ?? 'Unknown',
                imageUrl:
                    json['thumbnail'] ?? 'https://via.placeholder.com/150',
                price: 'LKR ${(json['price'] * 300).toStringAsFixed(2)}',
                description: json['description'] ?? 'No description available',
                subCategory: json['category'] ?? 'unknown',
              ))
          .toList();
    } else {
      throw Exception('Failed to load external JSON');
    }
  }

  Future<List<Product>> _loadLocalJson(String category) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/$category.json');
    final List<dynamic> data = jsonDecode(jsonString);
    return data
        .map((json) => Product(
              id: json['id']?.toString() ?? DateTime.now().toString(),
              name: json['name'] ?? 'Unknown',
              imageUrl: json['image_url'] ?? '',
              price: json['price'] ?? 'LKR 0.00',
              description: json['description'] ?? '',
              subCategory: json['sub_category'] ?? 'unknown',
            ))
        .toList();
  }

  Future<void> _saveToLocal(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(products.map((p) => p.toJson()).toList());
    await prefs.setString('$category-products', jsonString);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$category.json');
    await file.writeAsString(jsonString);
  }

  Future<List<Product>> loadFromLocal(String category) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('$category-products');
    if (jsonString != null) {
      final List<dynamic> data = jsonDecode(jsonString);
      return data.map((json) => Product.fromJson(json)).toList();
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$category.json');
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final List<dynamic> data = jsonDecode(jsonString);
      return data.map((json) => Product.fromJson(json)).toList();
    }

    return [];
  }
}

final productProvider = StateNotifierProvider.family<ProductNotifier,
    AsyncValue<List<Product>>, String>((ref, category) {
  return ProductNotifier(category);
});
