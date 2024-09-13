import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  ButtonPage({
    super.key,
  });

  final options = {
    'Ligar para a polícia': Icons.local_police,
    'Ligar para Delegacia da Mulher': Icons.balance,
    'Solicitar Ajuda Médica': Icons.local_hospital
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, João!',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor.withOpacity(0.6)),
              ),
              Center(
                child: Text(
                  'Precisa de ajuda urgente?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 36),
                ),
              ),
              Center(
                child: Text(
                  'Aperte o botão para ligar',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                ),
              ),
            ],
          ),
          IconButton.filled(
            style: IconButton.styleFrom(
                side: BorderSide(color: Color(0xFFBABDC8), width: 5)),
            onPressed: () {},
            icon: Icon(
              Icons.phone_rounded,
            ),
            padding: EdgeInsets.all(20),
            iconSize: 300,
          ),
          Column(
            children: [
              Text(
                'Não sabe o que fazer?',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                'Selecione uma das opções abaixo',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w400, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: .0),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 100, // Adjust the height according to your needs
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Set scroll direction to horizontal
                    itemCount:
                        options.keys.length, // Number of items in the list
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 150, // Adjust the width of each item
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  options.values.toList()[index],
                                  size: 35,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    options.keys.toList()[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
