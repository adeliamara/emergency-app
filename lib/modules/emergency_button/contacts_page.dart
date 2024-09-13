import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});

  final List<String> items = List.generate(4, (index) => 'Item $index');

  TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    // Lógica de pesquisa quando o ícone de lupa é pressionado
    print('Pesquisa: ${_searchController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Novas Solicitações',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        items == 0
            ? Center(child: Text('Não existem solicitações'))
            : SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * .9,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Fulano de tal',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.check)),
                              Divider(
                                height: 25,
                                color: Colors.grey,
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.close)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            indent: 10,
            endIndent: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Busque Seus Contatos',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Cor da borda quando desativado
                        width: 2.0,
                      ),
                      borderRadius:
                          BorderRadius.circular(20.0), // Borda arredondada
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red, // Cor da borda quando desativado
                        width: 2.0,
                      ),
                      borderRadius:
                          BorderRadius.circular(20.0), // Borda arredondada
                    ),
                    hintText: 'Digite sua pesquisa...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border:
                        InputBorder.none, // Remove a borda padrão do TextField
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _onSearch,
              ),
            ],
          ),
        ),
        items == 0
            ? Center(child: Text('Não existem solicitações'))
            : SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * .9,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Fulano de tal',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
