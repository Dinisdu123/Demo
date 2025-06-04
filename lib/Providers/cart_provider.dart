import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/cart_model.dart';

class CartState {
  final List<CartItem> items;
  final bool isLoading;
  final String? error;

  CartState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  final String baseUrl = 'http://127.0.0.1:8000/api/cart';

  CartNotifier() : super(CartState()) {
    fetchCartItems();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchCartItems() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No authentication token found');

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        final items = data.map((json) => CartItem.fromJson(json)).toList();
        state = state.copyWith(items: items, isLoading: false);
      } else {
        throw Exception('Failed to load cart: ${response.body}');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addToCart(String productId, int quantity) async {
    // Changed to String
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No authentication token found');

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 201) {
        await fetchCartItems(); // Refresh cart
      } else {
        throw Exception('Failed to add to cart: ${response.body}');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateCartItem(int id, int quantity) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No authentication token found');

      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        await fetchCartItems(); // Refresh cart
      } else {
        throw Exception('Failed to update cart: ${response.body}');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteCartItem(int id) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No authentication token found');

      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await fetchCartItems(); // Refresh cart
      } else {
        throw Exception('Failed to remove item: ${response.body}');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
