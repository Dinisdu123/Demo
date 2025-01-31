import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Roboto',
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    onSurface: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: 'Roboto',
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    onSurface: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
);
