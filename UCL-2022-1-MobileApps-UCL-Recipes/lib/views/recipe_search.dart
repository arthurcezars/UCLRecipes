import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';

class Ingredient {
  final int id;
  final String name;

  Ingredient({
    required this.id,
    required this.name,
  });
}

class RecipeSearch extends StatefulWidget {
  const RecipeSearch({Key? key}) : super(key: key);

  @override
  State<RecipeSearch> createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  static List<Ingredient> _ingredients = [
    Ingredient(id: 1, name: "macarrão"),
    Ingredient(id: 2, name: "alho")
  ];
  final _listIngredients = _ingredients
      .map((ingrendient) =>
          MultiSelectItem<Ingredient>(ingrendient, ingrendient.name))
      .toList();
  List<Ingredient> _selectedIngredients = [];
  bool _isLoading = false;

  // Future<void> _getIngredients() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final response = await supabase.from("ingredient").select("*").execute();
  //   final error = response.error;
  //   if (error != null && response.status != 406 && mounted) {
  //     showMessage(context, error.message);
  //   }
  //   final data = response.data;
  //   if (data != null) {
  //     // print(data);
  //     setState(() {
  //       _items = data
  //           .map((ingredient) =>
  //               MultiSelectItem<Ingredient>(ingredient, ingredient.name))
  //           .toList();
  //       _isLoading = false;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   _getIngredients();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Buscar receitas', appBar: AppBar()),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                  'Para buscar receitas, selecione os ingredientes que você possui disponíveis.'),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: !_isLoading
                  ? Column(
                      children: <Widget>[
                        MultiSelectBottomSheetField(
                          initialChildSize: 0.4,
                          listType: MultiSelectListType.CHIP,
                          searchable: true,
                          buttonText: const Text("Clique para selecionar"),
                          title: const Text("Ingredientes"),
                          items: _listIngredients,
                          onConfirm: (values) {
                            final newList = values.cast<Ingredient>();
                            setState(() {
                              _selectedIngredients = newList;
                            });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (value) {
                              setState(() {
                                _selectedIngredients.remove(value);
                              });
                            },
                          ),
                        ),
                        _selectedIngredients.isEmpty
                            ? Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 30, 10, 30),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Nenhum ingrediente selecionado",
                                ))
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/recipe_list');
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.orange),
                                  ),
                                  child: const Text('Pesquisar'),
                                ),
                              ),
                      ],
                    )
                  : const Text("Carregando lista de ingredientes..."),
            ),
          ],
        ),
      ),
    );
  }
}
