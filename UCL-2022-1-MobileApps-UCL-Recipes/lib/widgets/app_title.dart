import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String text;
  const AppTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.orange,
        fontWeight: FontWeight.w500,
        fontSize: 30,
      ),
    );
  }
}
