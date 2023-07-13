import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontFamily: 'speda'),
    bodyMedium: TextStyle(fontFamily: 'speda'),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: TextStyle(fontSize: 19, fontFamily: 'speda'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      foregroundColor: Color.fromARGB(255, 25, 167, 206),
      disabledForegroundColor: Colors.yellow.shade700,
      side: BorderSide(color: Color.fromARGB(255, 25, 167, 206), width: 1),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.yellow.shade700,
  inputDecorationTheme: InputDecorationTheme(
      border: outlineInputBorder,
      errorBorder: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      prefixIconColor: Colors.yellow.shade700,
      suffixIconColor: Colors.yellow.shade700),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow.shade700,
      disabledBackgroundColor: Colors.yellow.shade700,
      textStyle: TextStyle(fontFamily: 'speda', fontSize: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  //primarySwatch: Colors.yellow,
  canvasColor: Colors.yellow.shade600,
  appBarTheme: AppBarTheme(
    toolbarTextStyle: TextStyle(color: Colors.yellow.shade800),
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 137, 137)),
  ),
);
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color.fromARGB(255, 67, 66, 66),
  ),
  borderRadius: BorderRadius.circular(20),
);
