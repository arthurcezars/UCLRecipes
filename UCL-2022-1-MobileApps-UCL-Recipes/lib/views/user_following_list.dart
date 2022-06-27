import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/user.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/widgets/app_default_appbar.dart';
import 'package:ucl_recipes/widgets/user_tile.dart';

class UserFollowingList extends StatefulWidget {
  const UserFollowingList({Key? key}) : super(key: key);

  @override
  State<UserFollowingList> createState() => _UserFollowingListState();
}

class _UserFollowingListState extends State<UserFollowingList> {
  bool _isLoading = false;
  late final List<User> _listFolloweds = [];
  late final List<String> _listIdsFolloweds = [];

  // lista os IDs dos usuários que está seguindo
  Future<void> _getIdsFolloweds() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from('users')
        .select('*, user_follow!inner(*)')
        .eq("user_follow.id_user_follower",
            supabase.auth.currentSession!.user!.id)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
      final List<dynamic> data = response.data;
      if (data.isNotEmpty) {
        setState(() {
          for (var user in data[0]["user_follow"]) {
            _listIdsFolloweds.add(
              user["id_user_followed"],
            );
          }
          if (_listIdsFolloweds.isNotEmpty) _getFolloweds();
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  // lista os dados dos usuários que está seguindo
  Future<void> _getFolloweds() async {
    setState(() {
      _isLoading = true;
    });
    final response = await supabase
        .from("users")
        .select("*")
        .in_("id", _listIdsFolloweds)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
      final List<dynamic> data = response.data;
      setState(() {
        for (var user in data) {
          _listFolloweds.add(
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
    _getIdsFolloweds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Seguindo',
        appBar: AppBar(),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: _isLoading
            ? const Text("Carregando lista...")
            : _listFolloweds.isNotEmpty
                ? ListView.builder(
                    itemCount: _listFolloweds.length,
                    itemBuilder: (context, i) => UserTile(
                      user: _listFolloweds.elementAt(i),
                    ),
                  )
                : const Text("Você não segue ninguém até o momento..."),
      ),
    );
  }
}
