import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Recovery Password Page'),
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
