import 'package:emergency_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Login Page'),
          ElevatedButton(
            onPressed: () {
              context.go('/auth/register');
            },
            child: const Text('Navigate to register'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/auth/recovery-password');
            },
            child: const Text('Navigate to recovery password'),
          ),
          ElevatedButton(
            onPressed: () {
              navigatorKey.currentState!.pushReplacementNamed('/map');
            },
            child: const Text('Navigate to call'),
          )
        ],
      ),
    );
  }
}
