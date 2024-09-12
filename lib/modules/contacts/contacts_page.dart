import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Column(
        children: [
          Text('Contacts Page'),
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