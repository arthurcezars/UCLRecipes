import 'package:flutter/material.dart';
import 'package:ucl_recipes/views/recipe_details.dart';
import 'package:ucl_recipes/views/recipe_list.dart';
import 'package:ucl_recipes/views/recipe_search.dart';
import 'package:ucl_recipes/views/signin.dart';
import 'package:ucl_recipes/views/signup.dart';
import 'package:ucl_recipes/views/user_menu_account.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'UCL Recipes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(backgroundColor: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => const Signin(),
        '/signup': (context) => const Signup(),
        '/user_menu_account': (context) => const UserMenuAccount(),
        '/recipe_search': (context) => const RecipeSearch(),
        '/recipe_list': (context) => const RecipeList(),
        '/recipe_details': (context) => const RecipeDetails()
      },
    );
  }
}
