import 'package:emergency_app/core/test.dart';
import 'package:emergency_app/modules/emergency_feature/emergency_service.dart';
import 'package:flutter/material.dart';

import '../../../core/models/user.dart';

class UserList extends StatelessWidget {
  const UserList({
    required this.users,
    super.key,
  });

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          final sent = ValueNotifier(false);

          return ValueListenableBuilder(
              valueListenable: sent,
              builder: (context, hasSent, _) {
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            ' @${users[index].username} (${users[index].name})',
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
                              onPressed: hasSent
                                  ? null
                                  : () async {
                                      await emergencyService.sendSolicitation(
                                        ana.id,
                                        users[index].id,
                                      );
                                      sent.value = true;
                                    },
                              icon: !hasSent
                                  ? Icon(Icons.add)
                                  : Icon(
                                      Icons.schedule,
                                    )),
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }
}
