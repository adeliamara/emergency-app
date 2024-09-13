import 'package:flutter/material.dart';

import 'contacts_page.dart';
import 'profile_page.dart';
import 'button_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    ContactsPage(),
    ButtonPage(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF2F9),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_rounded),
            label: 'Contatos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_rounded),
            label: 'Botão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Perfil',
          )
        ],
      ),
      body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * .93),
              child: SafeArea(child: _pages[_currentIndex]))),
    );
  }
}
