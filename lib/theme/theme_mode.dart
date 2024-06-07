import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey.shade300,
    tertiary: Colors.grey.shade500,
    inversePrimary: Colors.white
  )
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade500,
    inversePrimary: Colors.grey.shade300,
  )
);