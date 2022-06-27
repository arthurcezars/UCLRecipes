import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/user.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/user_tile.dart';

class UserFollowersList extends StatefulWidget {
  const UserFollowersList({Key? key}) : super(key: key);

  @override
  State<UserFollowersList> createState() => _UserFollowersListState();
}

class _UserFollowersListState extends State<UserFollowersList> {
  bool _isLoading = false;
  late final List<User> _listFollowers = [];

  // lista os IDs dos seguidores
  Future<void> _getIdsFollowers() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('users')
        .select('*, user_follow!inner(*)')
        .eq("user_follow.id_user_followed",
            supabase.auth.currentSession!.user!.id)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
      final List<dynamic> data = response.data;
      setState(() {
        for (var user in data) {
          _listFollowers.add(
            User(
              id: user["id"],
              email: user["email"],
              name: user["metadata"]["name"],
              phone: user["metadata"]["phone"],
              password: "",
            ),
          );
        }
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getIdsFollowers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Seguidores',
        appBar: AppBar(),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: _isLoading
            ? const Text("Carregando lista...")
            : _listFollowers.isNotEmpty
                ? ListView.builder(
                    itemCount: _listFollowers.length,
                    itemBuilder: (context, i) => UserTile(
                      user: _listFollowers.elementAt(i),
                    ),
                  )
                : const Text("Você não possui seguidores até o momento..."),
      ),
    );
  }
}
