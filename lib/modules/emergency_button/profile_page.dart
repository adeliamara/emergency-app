import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final userData = {
    'Email': 'joaosousa@email.com',
    'Nome': 'Jose Sousa e Silva',
    'Telefone': '(86) 99987-8763',
    'Nascimento': '11/04/2004'
  };

  final userIcons = {
    'Email': Icons.email,
    'Nome': Icons.abc,
    'Telefone': Icons.phone,
    'Nascimento': Icons.calendar_today
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      color: Theme.of(context).primaryColor,
                    ),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '@joao2023',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.1), // Cor da sombra com leve transparência
                        spreadRadius: 1, // Espalhamento da sombra
                        blurRadius: 5, // Suavidade da sombra
                        offset:
                            Offset(0, 3), // Posição da sombra (deslocamento)
                      ),
                    ]),
                width: 400,
                height: 240,
                padding: EdgeInsets.all(15),
                child: ListView.separated(
                  shrinkWrap:
                      true, // Faz a ListView ocupar apenas o espaço necessário
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(userIcons.values.toList()[index]),
                          ),
                          Text(
                            userData.keys.toList()[index],
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Spacer(),
                          Text(userData.values.toList()[index]),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: userData.length,
                )),
            Spacer(
              flex: 4,
            ),
            SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Sair'),
                    icon: Icon(Icons.exit_to_app),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
