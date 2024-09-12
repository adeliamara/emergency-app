import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Profile Page'),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Pop do login'),
          )
        ],
      ),
    );
  }
}
