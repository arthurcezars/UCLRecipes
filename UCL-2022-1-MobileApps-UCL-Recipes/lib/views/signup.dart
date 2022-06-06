import 'package:flutter/material.dart';
import 'package:ucl_recipes/widgets/app_title.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                labelText: 'Digite seu nome',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite seu email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite seu telefone',
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
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
              child: const Text('Cadastrar'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text(
                  'Voltar',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
