import 'package:flutter/material.dart';

class AppTheme{
  static const bool isDark = true;

  static ThemeData appTheme = isDark == false? ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.light
  )
  : ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.dark
  );
}