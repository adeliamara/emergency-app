import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Call Page'),
          ElevatedButton(
            onPressed: () {
              context.go('/auth');
            },
            child: Text('Pop to login'),
          )
        ],
      ),
    );
  }
}
