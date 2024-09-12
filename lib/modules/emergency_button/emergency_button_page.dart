import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmergencyButtonPage extends StatelessWidget {
  const EmergencyButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Column(
        children: [
          Text('Emergency Button Page'),
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