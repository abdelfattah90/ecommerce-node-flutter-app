import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static const String baseUrl =
      'https://ecommerce-node-flutter-app.vercel.app/api/users';

  static Future<User?> register(
      String username, String password, String passwordConfirm) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register user');
    }
  }

  static Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<User?> googleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final response = await http.post(
        Uri.parse('$baseUrl/google-login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'googleId': googleUser.id,
          'username': googleUser.displayName ?? '',
        }),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to login with Google');
      }
    } else {
      throw Exception('Google login cancelled');
    }
  }
}
