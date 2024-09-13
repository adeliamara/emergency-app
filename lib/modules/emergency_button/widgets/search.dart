import 'package:emergency_app/modules/emergency_button/widgets/user_list.dart';
import 'package:flutter/material.dart';

import '../../../core/models/user.dart';

class UserSearchDelegate extends SearchDelegate {
  UserSearchDelegate({required this.users});

  late List<User> users;
  List<User> results = <User>[];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => results.isEmpty
      ? const Center(
          child: Text('No Results', style: TextStyle(fontSize: 24)),
        )
      : Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    results = users.where((User user) {
      final String name = user.name.toLowerCase();
      final String input = query.toLowerCase();

      return name.contains(input);
    }).toList();

    return results.isEmpty
        ? const Center(
            child: Text('No Results', style: TextStyle(fontSize: 24)),
          )
        : UserList(users: results);
  }
}
