import 'package:flutter/material.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';

class UserMenuAccount extends StatefulWidget {
  const UserMenuAccount({Key? key}) : super(key: key);

  @override
  State<UserMenuAccount> createState() => _UserMenuAccountState();
}

class _UserMenuAccountState extends State<UserMenuAccount> {
  final String _userName =
      (supabase.auth.currentSession?.user?.userMetadata["name"]!)!;
  final String _userEmail = (supabase.auth.currentSession?.user?.email)!;

  Future _signOut(BuildContext context) async {
    final response = await supabase.auth.signOut();
    if (!mounted) return;
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${response.error?.message}'),
        ),
      );
    } else {
      Navigator.pushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Minha conta', appBar: AppBar()),
      body: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.orangeAccent,
            ),
            accountName: Text(_userName),
            accountEmail: Text(_userEmail),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: const Text("Receitas salvas"),
                    trailing: const Icon(
                      Icons.bookmarks_rounded,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/recipe_list_user");
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text("Receitas avaliadas"),
                    trailing: const Icon(
                      Icons.star_rounded,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/recipe_list_user_score");
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text("Pessoas"),
                    trailing: const Icon(
                      Icons.supervisor_account_rounded,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/users_list");
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text("Seguidores"),
                    trailing: const Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/user_followers_list");
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text("Seguindo"),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/user_following_list");
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text("Sair"),
                    trailing: const Icon(
                      Icons.close_rounded,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      _signOut(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
