import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> register(
      String username, String password, String passwordConfirm) async {
    _user = await AuthService.register(username, password, passwordConfirm);
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    _user = await AuthService.login(username, password);
    notifyListeners();
  }

  Future<void> googleLogin() async {
    _user = await AuthService.googleLogin();
    notifyListeners();
  }
}
