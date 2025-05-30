import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthState {
  final bool isAuthenticated;
  final User? user;
  final String? error;

  AuthState({this.isAuthenticated = false, this.user, this.error});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('user_name');
      final email = prefs.getString('user_email');
      final id = prefs.getString('user_id');
      if (name != null && email != null && id != null) {
        state = AuthState(
          isAuthenticated: true,
          user: User(
            id: id,
            name: name,
            email: email,
            role: prefs.getString('user_role') ?? '',
            profilePhotoUrl: prefs.getString('user_profile_photo_url') ?? '',
            token: prefs.getString('auth_token') ?? '',
          ),
        );
      }
    } catch (e) {
      print('Error loading user: $e');
      state = AuthState(error: 'Failed to load user: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      print('Login response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User(
          id: (data['user']['id'] ?? 0).toString(),
          name: data['user']['name'] ?? 'Unknown',
          email: data['user']['email'] ?? email,
          role: data['user']['role'],
          profilePhotoUrl: data['user']['profile_photo_url'],
          token: data['token'], // Null for login
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', user.name);
        await prefs.setString('user_email', user.email);
        await prefs.setString('user_id', user.id);
        if (user.role != null) {
          await prefs.setString('user_role', user.role!);
        } else {
          await prefs.remove('user_role');
        }
        if (user.profilePhotoUrl != null) {
          await prefs.setString(
              'user_profile_photo_url', user.profilePhotoUrl!);
        } else {
          await prefs.remove('user_profile_photo_url');
        }
        if (user.token != null) {
          await prefs.setString('auth_token', user.token!);
        } else {
          await prefs.remove('auth_token');
        }
        state = AuthState(isAuthenticated: true, user: user);
      } else {
        final errorData = jsonDecode(response.body);
        state = AuthState(error: errorData['error'] ?? 'Invalid credentials');
      }
    } catch (e) {
      state = AuthState(error: 'Login failed: $e');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        }),
      );
      print('Register response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = User(
          id: (data['user']['id'] ?? 0).toString(),
          name: data['user']['name'] ?? name,
          email: data['user']['email'] ?? email,
          role: data['user']['role'] ?? 'customer',
          profilePhotoUrl: data['user']['profile_photo_url'],
          token: data['token'],
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', user.name);
        await prefs.setString('user_email', user.email);
        await prefs.setString('user_id', user.id);
        if (user.role != null) {
          await prefs.setString('user_role', user.role!);
        } else {
          await prefs.remove('user_role');
        }
        if (user.profilePhotoUrl != null) {
          await prefs.setString(
              'user_profile_photo_url', user.profilePhotoUrl!);
        } else {
          await prefs.remove('user_profile_photo_url');
        }
        if (user.token != null) {
          await prefs.setString('auth_token', user.token!);
        } else {
          await prefs.remove('auth_token');
        }
        state = AuthState(isAuthenticated: true, user: user);
      } else {
        final errorData = jsonDecode(response.body);
        state = AuthState(error: errorData['error'] ?? 'Registration failed');
      }
    } catch (e) {
      state = AuthState(error: 'Registration failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      state = AuthState();
    } catch (e) {
      state = AuthState(error: 'Logout failed: $e');
      print('Logout error: $e');
    }
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
