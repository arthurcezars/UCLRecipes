import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ucl_recipes/models/recipe.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/app_title.dart';

class RecipeDetails extends StatefulWidget {
  final Recipe? recipe;
  const RecipeDetails({Key? key, this.recipe}) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late int _idRecipe;
  late String _idUser;
  bool _isLoading = false;
  bool _recipeIsSaved = false;
  bool _recipeIsValued = false;
  int _recipeScore = 0;

  // verifica se a receita está na lista de favoritos do usuário
  Future<void> _getRecipeSaved() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('recipe_saved')
        .select('*')
        .eq("id_recipe", _idRecipe)
        .eq("id_user", _idUser)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    }
    dynamic data = response.data;
    setState(() {
      if (data != null && data.isNotEmpty) _recipeIsSaved = true;
      _isLoading = false;
    });
  }

  // verifica se o usuário avaliou a receita
  Future<void> _getRecipeScore() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('recipe_score')
        .select('score')
        .eq("id_recipe", _idRecipe)
        .eq("id_user", _idUser)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    }
    dynamic data = response.data;
    setState(() {
      if (data != null && data.isNotEmpty) {
        _recipeIsValued = true;
        _recipeScore = data[0]["score"];
      }
      _isLoading = false;
    });
  }

  // inclui/remove a receita na lista de favoritos do usuário
  Future<void> _setRecipeSaved() async {
    dynamic response;
    setState(() {
      _isLoading = true;
    });
    if (_recipeIsSaved) {
      response = await supabase
          .from('recipe_saved')
          .delete()
          .match({"id_recipe": _idRecipe, "id_user": _idUser}).execute();
    } else {
      response = await supabase
          .from('recipe_saved')
          .insert({"id_recipe": _idRecipe, "id_user": _idUser}).execute();
    }
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
      setState(() {
        _recipeIsSaved = !_recipeIsSaved;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  // inclui/atualiza a avaliação da receita feita pelo usuário
  Future<void> _setRecipeScore(int score) async {
    dynamic response;
    setState(() {
      _isLoading = true;
    });
    if (_recipeIsValued) {
      response = await supabase
          .from('recipe_score')
          .update({"score": score})
          .eq("id_recipe", _idRecipe)
          .eq("id_user", _idUser)
          .execute();
    } else {
      response = await supabase.from('recipe_score').insert({
        "id_recipe": _idRecipe,
        "id_user": _idUser,
        "score": score
      }).execute();
    }
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
      setState(() {
        _recipeIsValued = true;
        _recipeScore = score;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _idRecipe = widget.recipe!.id;
    _idUser = supabase.auth.currentSession!.user!.id;
    _getRecipeSaved();
    _getRecipeScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Minha conta',
        appBar: AppBar(),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(text: widget.recipe!.name),
            _isLoading
                ? const Text("Carregando...")
                : Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                color: Colors.orange[50],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text(
                                          'Atribua uma nota de 1 à 5 para essa receita.'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (var s in [1, 2, 3, 4, 5])
                                            IconButton(
                                              onPressed: () {
                                                _setRecipeScore(s);
                                                Navigator.pop(context);
                                              },
                                              icon: _recipeScore >= s
                                                  ? const Icon(
                                                      Icons.star_rounded,
                                                      size: 28,
                                                    )
                                                  : const Icon(
                                                      Icons.star_border_rounded,
                                                      size: 28,
                                                    ),
                                              color: Colors.orange,
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: _recipeIsValued
                            ? const Icon(
                                Icons.star_rounded,
                                size: 28,
                                color: Colors.orange,
                              )
                            : const Icon(
                                Icons.star_border_rounded,
                                size: 28,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          _setRecipeSaved();
                        },
                        icon: _recipeIsSaved
                            ? const Icon(
                                Icons.bookmark_added_rounded,
                                size: 24,
                                color: Colors.orange,
                              )
                            : const Icon(
                                Icons.bookmark_add_outlined,
                                size: 24,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            const ClipboardData(text: "http://www.ucl.br"),
                          );
                          showMessage(context, "Link copiado!");
                        },
                        icon: const Icon(
                          Icons.share_rounded,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(widget.recipe!.description),
            ),
          ],
        ),
      ),
    );
  }
}
