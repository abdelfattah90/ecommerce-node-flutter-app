import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _username;
  bool _isRegistered = false;

  String? get username => _username;
  bool get isRegistered => _isRegistered;

  Future<void> register(String username, String email, String password) async {
    final url = Uri.parse(
        'https://ecommerce-node-flutter-app.vercel.app/users/register');
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

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        _username = responseData['username'];
        _isRegistered = true;
        notifyListeners();
      } else {
        throw Exception('Failed to register');
      }
    } catch (error) {
      rethrow;
    }
  }
}
