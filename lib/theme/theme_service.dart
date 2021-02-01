import 'package:flutter/material.dart';

class ThemeService {
  static ThemeData darkTheme = ThemeData(
    backgroundColor: Color(0xFF16162F),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        wordSpacing: 5,
        height: 2,
        fontSize: 18,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.w600,
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Color(0xFF16162F),
      elevation: 0,
    ),
    scaffoldBackgroundColor: Color(0xFF16162F),
    canvasColor: Color(0xFF16162F),
  );
}
