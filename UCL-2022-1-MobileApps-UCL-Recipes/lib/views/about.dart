import 'package:flutter/material.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Sobre o App',
        appBar: AppBar(),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: const Text(
            "O aplicativo UCL Recipes tem como objetivo fornecer ao seu usuário uma ou mais receitas culinárias possíveis de realizar com os ingredientes que o mesmo possui disponíveis no momento. Além de listar, o usuário poderá criar sua lista de favoritos, avaliar, compartilhar receitas e se conectar com outros usuários.\n\nArthur Cezar - arthurcezars@ucl.br\nSavio Fonseca - saviofonseca@ucl.br\n\nUCL - 2022/1"),
      ),
    );
  }
}
