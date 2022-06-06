import 'package:flutter/material.dart';
import 'package:ucl_recipes/data/dummy_recipes.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/recipe_tile.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    const recipes = {...DUMMY_RECIPES};

    return Scaffold(
      appBar: DefaultAppBar(title: 'Receitas encontradas', appBar: AppBar()),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, i) =>
              RecipeTile(recipe: recipes.values.elementAt(i)),
        ),
      ),
    );
  }
}
