import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  const DefaultAppBar({Key? key, required this.title, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              if (ModalRoute.of(context)?.settings.name != "/recipe_search")
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/recipe_search');
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                ),
              if (ModalRoute.of(context)?.settings.name != "/user_menu_account")
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user_menu_account');
                  },
                  icon: const Icon(
                    Icons.account_circle_rounded,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
