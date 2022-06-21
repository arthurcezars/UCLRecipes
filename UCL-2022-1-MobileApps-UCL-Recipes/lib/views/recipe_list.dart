import 'package:flutter/material.dart';
// import 'package:ucl_recipes/data/dummy_recipes.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key, required this.ingredients});

  final List<dynamic> ingredients;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  bool _isLoading = false;

  Future<void> _getRecipes() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('recipe')
        .select("*, recipe_ingredient!inner(*)")
        .eq("recipe_ingredient.id_ingredient", 1)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    }
    print(response.data);
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
    // const recipes = {...DUMMY_RECIPES};

    return Scaffold(
      appBar: DefaultAppBar(title: 'Receitas encontradas', appBar: AppBar()),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Text(widget.ingredients[0].id.toString()),
        // ListView.builder(
        //   itemCount: recipes.length,
        //   itemBuilder: (context, i) =>
        //       RecipeTile(recipe: recipes.values.elementAt(i)),
        // ),
      ),
    );
  }
}
