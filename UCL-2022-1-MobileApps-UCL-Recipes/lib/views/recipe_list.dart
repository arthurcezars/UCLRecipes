import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/recipe.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/views/recipe_search.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/recipe_tile.dart';

class RecipeList extends StatefulWidget {
  final List<Ingredient>? ingredients;
  const RecipeList({super.key, this.ingredients});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  bool _isLoading = false;
  late final List<int> _listIdIngredients = [];
  late final List<Recipe> _listFoundRecipes = [];

  void _selectIdsIngredients() {
    widget.ingredients?.forEach(
      (ingredient) => _listIdIngredients.add(ingredient.id),
    );
  }

  // seleciona as receitas que possuem o(s) ingrediente(s) selecionados
  Future<void> _getRecipes() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('recipe')
        .select('*, recipe_ingredient!inner(*)')
        .in_("recipe_ingredient.id_ingredient", _listIdIngredients)
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
    _selectIdsIngredients();
    _getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Receitas encontradas',
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
