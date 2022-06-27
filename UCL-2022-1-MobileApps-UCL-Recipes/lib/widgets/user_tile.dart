import 'package:flutter/material.dart';
import 'package:ucl_recipes/models/user.dart';
import 'package:ucl_recipes/utils/constants.dart';
import 'package:ucl_recipes/utils/helpers.dart';
import 'package:ucl_recipes/views/user_recipes_list.dart';

class UserTile extends StatefulWidget {
  final User user;
  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool _isFollowed = false;

  Future<void> _getFollow() async {
    final response = await supabase
        .from('user_follow')
        .select('*')
        .eq("id_user_follower", supabase.auth.currentSession!.user!.id)
        .eq("id_user_followed", widget.user.id)
        .execute();
    final error = response.error;
    if (error != null && response.status != 406 && mounted) {
      showMessage(context, error.message);
    } else {
      final List<dynamic> data = response.data;
      setState(() {
        if (data.isNotEmpty) _isFollowed = true;
      });
    }
  }

  Future<void> _setFollow(String idFollowed) async {
    if (_isFollowed) {
      await supabase.from('user_follow').delete().match({
        "id_user_follower": supabase.auth.currentSession!.user!.id,
        "id_user_followed": idFollowed
      }).execute();
    } else {
      await supabase.from('user_follow').insert({
        "id_user_follower": supabase.auth.currentSession!.user!.id,
        "id_user_followed": idFollowed
      }).execute();
    }
    setState(() {
      _isFollowed = !_isFollowed;
    });
  }

  @override
  void initState() {
    _getFollow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title: Text(widget.user.name),
            trailing: IconButton(
              onPressed: () => _setFollow(widget.user.id),
              icon: _isFollowed
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.orange,
                    )
                  : const Icon(
                      Icons.check_rounded,
                    ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserRecipesList(idUser: widget.user.id),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
