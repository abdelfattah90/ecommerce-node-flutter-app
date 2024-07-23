// providers/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isRegistered = false;

  User? get user => _user;
  bool get isRegistered => _isRegistered;

  Future<void> register(String username, String email, String password) async {
    final url = Uri.parse(
        'https://ecommerce-node-flutter-app.vercel.app/api/users/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        _user = User.fromJson(responseData);
        _isRegistered = true;
        notifyListeners();
      } else {
        print('Registration failed with status code ${response.statusCode}');
        throw Exception('Failed to register');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
