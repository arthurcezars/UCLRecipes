import 'package:flutter/material.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';

class RecipeSearch extends StatelessWidget {
  const RecipeSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: DefaultAppBar(title: 'Buscar receitas', appBar: AppBar()),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                  'Para buscar receitas, digite os ingredientes que você possui disponíveis.'),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                '*Um ingrediente por vez.',
                style: TextStyle(fontSize: 12, color: Colors.orange),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite o nome do ingrediente',
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print(searchController.text);
                  Navigator.pushNamed(context, '/recipe_list');
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                child: const Text('Pesquisar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
