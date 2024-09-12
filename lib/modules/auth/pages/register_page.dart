import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Register Page'),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Pop to login'),
          )
        ],
      ),
    );
  }
}
