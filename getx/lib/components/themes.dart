import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData.light()
      .copyWith(appBarTheme: AppBarTheme(backgroundColor: Colors.brown ));
  static ThemeData darkTheme = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Colors.red, centerTitle: true));
}
