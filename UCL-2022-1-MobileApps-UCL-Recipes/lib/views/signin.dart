import 'package:flutter/material.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_title.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future _signIn(BuildContext context) async {
    final response = await Supabase.instance.client.auth
        .signIn(email: emailController.text, password: passwordController.text);
    if (!mounted) return;
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${response.error?.message}'),
        ),
      );
    } else {
      Navigator.pushNamed(context, '/recipe_search');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const AppTitle(text: "UCL Recipes"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: emailController,
                validator: (value) => validateEmail(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite seu email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                validator: (value) => validatePassword(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite sua senha',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  if (validateForm(_formKey, context)) {
                    //   _supabase.signIn(
                    //     context,
                    //     email: emailController.text,
                    //     password: passwordController.text,
                    //   );
                    _signIn(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                child: const Text('Acessar'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'Cadastrar',
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
