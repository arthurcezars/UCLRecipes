import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/recipe.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/recipe_tile.dart';

class UserRecipesList extends StatefulWidget {
  final String? idUser;
  const UserRecipesList({super.key, this.idUser});

  @override
  State<UserRecipesList> createState() => _UserRecipesListState();
}

class _UserRecipesListState extends State<UserRecipesList> {
  bool _isLoading = false;
  late final List<Recipe> _listFoundRecipes = [];

  // seleciona as receitas salvas pelo usuário
  Future<void> _getUserRecipes() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('recipe')
        .select('*, recipe_saved!inner(*)')
        .eq("recipe_saved.id_user", widget.idUser)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    }
    final List<dynamic> data = response.data;
    setState(() {
      for (var recipe in data) {
        _listFoundRecipes.add(
          Recipe(
            id: recipe["id"],
            name: recipe["name"],
            description: recipe["description"],
          ),
        );
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getUserRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Receitas salvas',
        appBar: AppBar(),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: _isLoading
            ? const Text("Carregando receitas...")
            : _listFoundRecipes.isNotEmpty
                ? ListView.builder(
                    itemCount: _listFoundRecipes.length,
                    itemBuilder: (context, i) => RecipeTile(
                      recipe: _listFoundRecipes.elementAt(i),
                    ),
                  )
                : const Text("Nenhuma receita encontrada..."),
      ),
    );
  }
}
