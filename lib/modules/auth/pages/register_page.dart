import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/components/button.dart';
import 'package:emergency_app/components/input.dart';
import 'package:emergency_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final db = FirebaseFirestore.instance;

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
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      await db.collection('/users').doc(user!.uid).set({
        'email': email,
        'id': user.uid,
        'name': name,
      });

      _showMessage(context, 'Registration successful!');

      _emailController.clear();
      _nameController.clear();
      _passwordController.clear();

      navigatorKey.currentState!.pop();
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
      backgroundColor: const Color(0xffEFF2F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffEFF2F9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(children: [
              Image.asset('assets/images/sirene.png'),
              const Text(
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
                const SizedBox(height: 16.0),
                Input(
                  controller: _nameController,
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                const SizedBox(height: 16.0),
                Input(
                  controller: _passwordController,
                  obscureText: true,
                  labelText: 'Password',
                  hintText: 'Password',
                ),
                const SizedBox(height: 16.0),
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
