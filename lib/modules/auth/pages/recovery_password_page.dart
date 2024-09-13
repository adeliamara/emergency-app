import 'dart:ffi';

import 'package:emergency_app/components/button.dart';
import 'package:emergency_app/components/input.dart';
import 'package:emergency_app/modules/auth/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RecoveryPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  // const RecoveryPasswordPage({super.key});

  Future<void> handlePressed(BuildContext context) async {
    String email = _emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor escreva o email'),
        ),
      );

      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The email was sent'),
      ));

      _emailController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Algo deu errado. Tente novamente!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xffEFF2F9),
      ),
      backgroundColor: Color(0xffEFF2F9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(children: [
              Image.asset('assets/images/sirene.png'),
              Text(
                "Emergenciers",
                style: TextStyle(color: Color(0xffff3b30), fontSize: 35),
              )
            ]),
            Column(
              children: [
                Text(
                  "Digite o seu email",
                  style: TextStyle(fontSize: 22.0, color: Color(0xffff3b30)),
                ),
                Text(
                  "Enviaremos um link para o seu email para alterar a sua senha",
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ),
                SizedBox(height: 30.0),
                Input(
                  hintText: "Email",
                  controller: _emailController,
                  borderRadius: 25.0,
                  fillColor: Color(0xffF9FBFF),
                  prefixIcon: Icons.email,
                  labelText: 'Email',
                  textColor: Color(0xffBABDC8),
                ),
              ],
            ),
            Button(
                text: "RESETAR A SENHA",
                width: 220.0,
                onPressed: () {
                  handlePressed(context);
                })
          ],
        ),
      ),
    );
  }
}
