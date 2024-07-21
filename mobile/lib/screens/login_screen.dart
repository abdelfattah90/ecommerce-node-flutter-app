import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.login(
        _usernameController.text,
        _passwordController.text,
      );
      // Navigate to another screen on successful login
    } catch (error) {
      // Handle login error
    }
  }

  void _googleLogin() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.googleLogin();
      // Navigate to another screen on successful Google login
    } catch (error) {
      // Handle Google login error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: _googleLogin,
              child: const Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
