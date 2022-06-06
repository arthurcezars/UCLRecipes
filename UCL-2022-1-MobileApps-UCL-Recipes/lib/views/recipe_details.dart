import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/recipe.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/app_title.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({Key? key}) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as RecipeDetailsArguments;

    return Scaffold(
      appBar: DefaultAppBar(title: 'Minha conta', appBar: AppBar()),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(text: args.recipe.name),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star_border_rounded,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share_rounded,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border_rounded,
                    size: 24,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(args.recipe.description),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailsArguments {
  final Recipe recipe;

  RecipeDetailsArguments(this.recipe);
}
