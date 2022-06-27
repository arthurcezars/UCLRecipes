import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/user.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/user_tile.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  bool _isLoading = false;
  late final List<User> _listUsers = [];

  // seleciona os usuários cadastrados no app
  Future<void> _getUsers() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('users')
        .select('*')
        .neq("id", supabase.auth.currentSession!.user!.id)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
      final List<dynamic> data = response.data;
      setState(() {
        for (var user in data) {
          _listUsers.add(
            User(
              id: user["id"],
              email: user["email"],
              name: user["metadata"]["name"],
              phone: user["metadata"]["phone"],
              password: "",
            ),
          );
        }
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Pessoas',
        appBar: AppBar(),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: _isLoading
            ? const Text("Carregando pessoa...")
            : _listUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _listUsers.length,
                    itemBuilder: (context, i) => UserTile(
                      user: _listUsers.elementAt(i),
                    ),
                  )
                : const Text("Nenhuma pessoa encontrada..."),
      ),
    );
  }
}
