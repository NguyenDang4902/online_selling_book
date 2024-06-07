import 'package:flutter/material.dart';
import 'package:online_selling_book/components/my_text_design.dart';

class MyInfoBar extends StatelessWidget {
  const MyInfoBar({super.key, required this.title});
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 5),
        color: Color.fromARGB(197, 72, 199, 82),
        width: MediaQuery.of(context).size.width,
        child: MyTextDesign(text: title),
      );
  }
}