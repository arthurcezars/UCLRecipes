import 'package:flutter/material.dart';
// import 'package:ucl_recipes/services/supabase_services.dart';
import 'package:ucl_recipes/views/recipe_details.dart';
import 'package:ucl_recipes/views/recipe_list.dart';
import 'package:ucl_recipes/views/recipe_search.dart';
import 'package:ucl_recipes/views/signin.dart';
import 'package:ucl_recipes/views/signup.dart';
import 'package:ucl_recipes/views/user_menu_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://url.supabase.co',
      anonKey: 'anonKey',
      authCallbackUrlHostname: 'login-callback', // optional
      debug: true // optional
      );

  // print(Supabase.instance.client.auth.currentSession?.toJson().toString());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final bool _isLogged = Supabase.instance.client.auth.currentSession != null;
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
      initialRoute: _isLogged ? '/recipe_search' : '/',
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
