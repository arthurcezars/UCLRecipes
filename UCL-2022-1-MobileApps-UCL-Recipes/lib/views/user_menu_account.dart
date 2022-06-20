import 'package:flutter/material.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserMenuAccount extends StatefulWidget {
  const UserMenuAccount({Key? key}) : super(key: key);

  @override
  State<UserMenuAccount> createState() => _UserMenuAccountState();
}

class _UserMenuAccountState extends State<UserMenuAccount> {
  final String _userName = (Supabase
      .instance.client.auth.currentSession?.user?.userMetadata["name"]!)!;
  final String _userEmail =
      (Supabase.instance.client.auth.currentSession?.user?.email)!;

  Future _signOut(BuildContext context) async {
    final response = await Supabase.instance.client.auth.signOut();
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
                      Navigator.pushNamed(context, "/recipe_list");
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
                      Navigator.pushNamed(context, "/recipe_list");
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
