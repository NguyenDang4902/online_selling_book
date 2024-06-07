import 'package:flutter/material.dart';
import 'package:online_selling_book/components/my_text_design.dart';

class MyButtonDesign extends StatelessWidget {
  const MyButtonDesign({super.key, required this.title, required this.function});

  final String title;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => function!(),
        child: Container(
            color: Theme.of(context).colorScheme.tertiary,
            height: MediaQuery.of(context).size.height * 1 / 20,
            width: MediaQuery.of(context).size.width * 1 / 4,
            child: Center(child: MyTextDesign(text: title))),
      );
  }
}