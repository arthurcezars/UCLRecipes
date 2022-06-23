import 'package:flutter/material.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/views/recipe_details.dart';
import 'package:ucl_recipes/views/recipe_list.dart';
import 'package:ucl_recipes/views/recipe_list_user.dart';
import 'package:ucl_recipes/views/recipe_list_user_score.dart';
import 'package:ucl_recipes/views/recipe_search.dart';
import 'package:ucl_recipes/views/signin.dart';
import 'package:ucl_recipes/views/signup.dart';
import 'package:ucl_recipes/views/user_menu_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rqgvzrddrbnfbxqnlait.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJxZ3Z6cmRkcmJuZmJ4cW5sYWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTU0MTM3MzQsImV4cCI6MTk3MDk4OTczNH0.gdcmGBNDAiqQaga3021EgF7xF5Kf_KOpgizCfYFFsEY',
    // authCallbackUrlHostname: 'login-callback', // optional
    // debug: true // optional
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'UCL Recipes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        backgroundColor: Colors.orange,
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: session != null ? '/recipe_search' : '/',
      routes: {
        '/': (context) => const Signin(),
        '/signup': (context) => const Signup(),
        '/user_menu_account': (context) => const UserMenuAccount(),
        '/recipe_search': (context) => const RecipeSearch(),
        '/recipe_list': (context) => const RecipeList(),
        '/recipe_list_user': (context) => const RecipeListUser(),
        '/recipe_list_user_score': (context) => const RecipeListUserScore(),
        '/recipe_details': (context) => const RecipeDetails()
      },
    );
  }
}
