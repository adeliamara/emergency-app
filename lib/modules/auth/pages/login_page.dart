import 'package:emergency_app/components/button.dart';
import 'package:emergency_app/components/input.dart';
import 'package:emergency_app/modules/auth/pages/recovery_password_page.dart';
import 'package:emergency_app/modules/auth/pages/register_page.dart';
import 'package:emergency_app/modules/emergency_button/emergency_button_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergency_app/main.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> handleLogin(BuildContext context) async {
    String username = _emailController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both username and password'),
        ),
      );

      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login concluído'),
        ),
      );

      _emailController.clear();
      _passwordController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmergencyButtonPage()),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // Show a specific message for "user-not-found"
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Nenhum usuário foi encontrado para esse email'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          // Show a specific message for "wrong-password"
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email ou senha inválidos'),
            ),
          );
        } else {
          // Handle other types of errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro nas suas credenciais'),
            ),
          );
        }
      }
    }
  }

  hadleTab() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      //   centerTitle: true,
      // ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Input(
                  hintText: "Email",
                  controller: _emailController,
                  borderRadius: 25.0,
                  fillColor: Color(0xffF9FBFF),
                  prefixIcon: Icons.email,
                  labelText: 'Email',
                  textColor: Color(0xffBABDC8),
                ),
                SizedBox(height: 16.0),
                Input(
                  obscureText: true,
                  controller: _passwordController,
                  labelText: 'Senha',
                  hintText: 'Senha',
                  borderRadius: 25,
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: Text(
                    "Esqueci minha senha",
                    style: TextStyle(color: Color(0xffff3b30)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecoveryPasswordPage()),
                    );
                  },
                ),
                SizedBox(height: 22.0),
                Button(
                  text: 'ENTRAR',
                  onPressed: () {
                    handleLogin(context);
                  },
                ),
                SizedBox(height: 16.0),
                Button(
                  text: 'CRIAR CONTA',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),      
      ),
    );
  }
}
