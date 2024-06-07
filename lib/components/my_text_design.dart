import 'package:flutter/material.dart';

class MyTextDesign extends StatelessWidget {
  const MyTextDesign({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
      );
  }
}
