import 'package:emergency_app/components/button.dart';
import 'package:emergency_app/components/input.dart';
import 'package:emergency_app/modules/auth/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

  Future<void> onRegister(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String name = _nameController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      _showMessage(context, 'All fields are required.');
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage(context, 'Please enter a valid email address.');
      return;
    }

    if (password.length < 6) {
      _showMessage(context, 'Password must be at least 6 characters long.');
      return;
    }

    try {
      print('Registering user...');
      print('Email: $email');
      print('Name: $name');
      print('Password: $password');

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      print(userCredential);

      _showMessage(context, 'Registration successful!');

      _emailController.clear();
      _nameController.clear();
      _passwordController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      _showMessage(context, 'Registration failed: $e');
    }
  }

  bool _isValidEmail(String email) {
    // Simple email regex for validation
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF2F9),
      appBar: AppBar(
        backgroundColor: Color(0xffEFF2F9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(children: [
              Image.asset('assets/images/sirene.png'),
              Text(
                "Emergenciers",
                style: TextStyle(color: Color(0xffff3b30), fontSize: 35),
              )
            ]),
            Column(
              children: [
                Input(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Email',
                ),
                SizedBox(height: 16.0),
                Input(
                  controller: _nameController,
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                SizedBox(height: 16.0),
                Input(
                  controller: _passwordController,
                  obscureText: true,
                  labelText: 'Password',
                  hintText: 'Password',
                ),
                SizedBox(height: 16.0),
              ],
            ),
            Button(
              height: 50,
              text: 'CRIAR CONTA',
              onPressed: () {
                onRegister(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
