import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login Page'),
          ElevatedButton(
            onPressed: () => context.go('/auth/register'),
            child: Text('Navigate to register'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/auth/recovery-password'),
            child: Text('Navigate to recovery password'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/call'),
            child: Text('Navigate to call'),
          )
        ],
      ),
    );
  }
}
