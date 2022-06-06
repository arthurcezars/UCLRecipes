import 'package:flutter/material.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';

class UserMenuAccount extends StatelessWidget {
  const UserMenuAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Minha conta', appBar: AppBar()),
      body: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://img.freepik.com/free-psd/3d-illustration-person_23-2149436182.jpg?t=st=1654484568~exp=1654485168~hmac=219dc58ab0a787407b8b7718b4c6c95b468ebdc5aa32a99c223ef39c2d21ca59&w=740"),
            ),
            accountName: Text("Nome do Usuário Logado"),
            accountEmail: Text("email@dominio.com"),
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
                      Navigator.pushNamed(context, "/");
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
