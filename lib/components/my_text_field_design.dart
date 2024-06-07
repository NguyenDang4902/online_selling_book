import 'package:flutter/material.dart';
import 'package:online_selling_book/components/my_text_design.dart';

class MyTextFieldDesign extends StatelessWidget {
  MyTextFieldDesign(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller,
      required this.inputType,
      required this.isFocus});

  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  bool isFocus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextDesign(
          text: title,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 3 / 5,
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            autofocus: isFocus,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                border: UnderlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
