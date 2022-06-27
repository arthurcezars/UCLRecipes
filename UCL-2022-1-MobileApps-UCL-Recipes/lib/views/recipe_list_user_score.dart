import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/recipe.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/recipe_tile.dart';

class RecipeListUserScore extends StatefulWidget {
  const RecipeListUserScore({super.key});

  @override
  State<RecipeListUserScore> createState() => _RecipeListUserScoreState();
}

class _RecipeListUserScoreState extends State<RecipeListUserScore> {
  bool _isLoading = false;
  final String _idUser = supabase.auth.currentSession!.user!.id;
  late final List<Recipe> _listFoundRecipes = [];

  // seleciona as receitas avaliadas pelo usuário
  Future<void> _getRecipes() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('recipe')
        .select('*, recipe_score!inner(*)')
        .eq("recipe_score.id_user", _idUser)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
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
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Receitas avaliadas',
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
                : const Text("Você não possui nenhuma receita encontrada..."),
      ),
    );
  }
}
