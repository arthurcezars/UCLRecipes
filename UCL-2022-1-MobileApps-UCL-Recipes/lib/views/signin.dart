import 'package:flutter/material.dart';
import 'package:ucl_recipes/widgets/app_title.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              controller: nameController,
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
                print(nameController.text);
                print(passwordController.text);
                Navigator.pushNamed(context, '/recipe_search');
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
    );
  }
}
