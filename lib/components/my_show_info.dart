import 'package:flutter/material.dart';
import 'package:online_selling_book/components/my_text_design.dart';

class MyShowInfo extends StatelessWidget {
  const MyShowInfo({super.key, required this.title, required this.text});
  
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyTextDesign(text: title),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 1 / 50,
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: MyTextDesign(text: text),
          )
        ],
      );;
  }
}