import 'package:flutter/material.dart';

import '../../core/models/user.dart';
import '../../core/test.dart';
import '../emergency_feature/emergency_service.dart';
import 'widgets/search.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});

  final mySolicitations = ValueNotifier<List<Map<String, User>>>([]);
  final loadedSolicitations = ValueNotifier<bool>(false);

  final myContacts = ValueNotifier<List<User>>([]);

  Future<void> loadMyContacts() async {
    final contacts =
        await emergencyService.fetchSolicitationUsers(ana.contacts!);
    myContacts.value = contacts;
  }

  Future<void> loadMySolicitations() async {
    final List<Map<String, String>> solicitations =
        await emergencyService.fetchRecievedSolicitations(ana.id);

    final userIds = solicitations.map((e) => e.values.first).toList();
    if (userIds.isEmpty) {
      loadedSolicitations.value = true;
      return;
    }
    final users = await emergencyService.fetchSolicitationUsers(userIds);

    final Map<String, User> userMap = {for (var user in users) user.id: user};

    final List<Map<String, User>> result = solicitations.map((solicitation) {
      final String solicitationId = solicitation.keys.first;
      final String userId = solicitation.values.first;
      final User? user = userMap[userId];

      return {solicitationId: user!};
    }).toList();

    mySolicitations.value = result;
    loadedSolicitations.value = true;
  }

  @override
  Widget build(BuildContext context) {
    loadMySolicitations();
    loadMyContacts();
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
        ValueListenableBuilder(
            valueListenable: loadedSolicitations,
            builder: (context, loaded, _) {
              if (!loaded) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return mySolicitations.value.isEmpty
                  ? const Center(child: Text('Não existem solicitações'))
                  : SizedBox(
                      height: 250,
                      child: ValueListenableBuilder(
                          valueListenable: mySolicitations,
                          builder: (context, solicitations, _) {
                            return ListView.builder(
                              itemCount: solicitations.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: MediaQuery.of(context).size.width * .9,
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '@${solicitations[index].values.first.username} (${solicitations[index].values.first.name})',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                await emergencyService
                                                    .acceptSolicitation(
                                                  solicitations[index]
                                                      .keys
                                                      .first,
                                                  true,
                                                );

                                                // Remova o item e notifique a alteração
                                                final updatedSolicitations =
                                                    List<
                                                            Map<String,
                                                                User>>.from(
                                                        solicitations);
                                                updatedSolicitations
                                                    .removeAt(index);

                                                mySolicitations.value =
                                                    updatedSolicitations;
                                              },
                                              icon: const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )),
                                          IconButton(
                                              onPressed: () async {
                                                await emergencyService
                                                    .acceptSolicitation(
                                                  solicitations[index]
                                                      .keys
                                                      .first,
                                                  false,
                                                );

                                                // Remova o item e notifique a alteração
                                                final updatedSolicitations =
                                                    List<
                                                            Map<String,
                                                                User>>.from(
                                                        solicitations);
                                                updatedSolicitations
                                                    .removeAt(index);

                                                mySolicitations.value =
                                                    updatedSolicitations;
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                    );
            }),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            indent: 10,
            endIndent: 10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
            ElevatedButton.icon(
              label: Text('Novo'),
              icon: const Icon(Icons.add),
              onPressed: () async {
                final users = await emergencyService.fetchUsers(ana.id);
                await showSearch(
                    context: context,
                    delegate: UserSearchDelegate(users: users));
              },
            ),
          ],
        ),
        ValueListenableBuilder(
            valueListenable: myContacts,
            builder: (context, contacts, _) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: contacts.isEmpty
                    ? Center(child: Text('Você não possui contatos'))
                    : SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width * .9,
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${contacts[index].name} (@${contacts[index].username})',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              );
            }),
      ],
    );
  }
}
