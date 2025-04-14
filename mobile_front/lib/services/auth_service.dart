import 'package:appli/models/user.dart';
import 'package:appli/services/api_service.dart';
import 'package:appli/utils/storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Register a new user
  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    final result = await ApiService.post('/auth/register', {
      'username': username,
      'email': email,
      'password': password,
    });

    if (result['success']) {
      // Store token and user data
      await StorageUtil.storeToken(result['data']['token']);

      if (result['data']['user'] != null) {
        final user = User(
          id: result['data']['user']['id'],
          email: result['data']['user']['email'],
        );
        await StorageUtil.storeUser(user);
      }
    }

    return result;
  }

  // Login user
  Future<Map<String, dynamic>> login(String email, String password) async {
    final result = await ApiService.post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (result['success']) {
      // Store token and user data
      await StorageUtil.storeToken(result['data']['token']);

      if (result['data']['user'] != null) {
        final user = User(
          id: result['data']['user']['id'],
          email: result['data']['user']['email'],
        );
        await StorageUtil.storeUser(user);
      }
    }

    return result;
  }

  // Request password reset
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    return await ApiService.post('/auth/forgot-password', {'email': email});
  }

  // Logout
  Future<void> logout() async {
    await StorageUtil.clearAll();
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await StorageUtil.getToken();
    return token != null && token.isNotEmpty;
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    return await StorageUtil.getUser();
  }

  // Get user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    return await ApiService.get('/user/profile');
  }
}
