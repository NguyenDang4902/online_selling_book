import 'package:flutter/material.dart';
import 'package:online_selling_book/pages/bill_calculator.dart';
import 'package:online_selling_book/theme/calculate_provider.dart';
import 'package:online_selling_book/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // theme change
      ChangeNotifierProvider(
        create: ((context) => ThemeProvider()),
        child: const MyApp(),
      ),
      // calculate
      ChangeNotifierProvider(
        create: ((context) => CalculateProvider()),
        child: const MyApp(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const BillCalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}
