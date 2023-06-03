import 'package:flutter/material.dart';

class Pallete {
  static const Color bgColor = Color(0xfff1f6fc);
  static const Color primaryColor = Color(0xff00a386);
  static const Color cardColor = Color(0xfffcfeff);
  static const Color inputBg = Color.fromARGB(32, 142, 142, 142);
  static const Color orangeColor = Color(0xfff9af40);
}

final lightTheme = ThemeData(
  primarySwatch: Colors.green,
).copyWith(
  scaffoldBackgroundColor: Pallete.bgColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.bgColor,
    titleTextStyle: TextStyle(
      color: Pallete.primaryColor,
      fontSize: 20,
    ),
    centerTitle: true,
  ),
);
