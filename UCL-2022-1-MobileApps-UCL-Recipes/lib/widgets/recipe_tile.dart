import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/recipe.dart';
import 'package:ucl_recipes/views/recipe_details.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  const RecipeTile({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.food_bank_rounded),
            title: Text(recipe.name),
            trailing: const Icon(Icons.remove_red_eye_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetails(recipe: recipe),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
