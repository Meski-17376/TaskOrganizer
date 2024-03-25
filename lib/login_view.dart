import 'package:flutter/material.dart';
import 'authentication_service.dart'; // Import your AuthenticationService
import 'package:firebase_auth/firebase_auth.dart';
class LoginView extends StatefulWidget {
  const LoginView ({super.key});
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final AuthenticationService authService = AuthenticationService(FirebaseAuth.instance); // Initialize your AuthService
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

void _login() async {
  String email = _emailController.text;
  String password = _passwordController.text;

  String? result = await authService.signIn(email: email, password: password);

  if (!mounted) return; // Check if the widget is still in the tree

  if (result == "Signed in") {
    // Navigate to your main app screen or dashboard
  } else {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result ?? "Login failed")));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            // You might also want to add a 'Register' button here
          ],
        ),
      ),
    );
  }
}
