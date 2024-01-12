import 'package:flutter/material.dart';
import 'package:note_pad_hive/utils/custom_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late bool _isDarkMode;
  late ThemeData _themeData;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeProvider() {
    _isDarkMode = false; // Set the default theme
    _themeData = _isDarkMode ? _darkTheme : _lightTheme;
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;
  ThemeData get themeData => _themeData;

  final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    // Add other light mode theme configurations
  );

  final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    // Add other dark mode theme configurations
  );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? _darkTheme : _lightTheme;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(CustomStrings.themeKey, _isDarkMode);
  }

  Future<void> _loadTheme() async {
    final SharedPreferences prefs = await _prefs;
    _isDarkMode = prefs.getBool(CustomStrings.themeKey) ?? false;
    _themeData = _isDarkMode ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
