import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { Light, Dark }

class ThemeManager with ChangeNotifier {
  late ThemeData _themeData;
  late AppTheme _currentTheme;

  ThemeManager() {
    _currentTheme = AppTheme.Light;
    _themeData = ThemeData.light(); // Set the default theme
    _loadTheme();
  }

  AppTheme get currentTheme => _currentTheme;
  ThemeData get themeData => _themeData;

  get darkThemeData => null;

  get currentThemeMode => null;

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeIndex = prefs.getInt('theme') ?? 0;
    _currentTheme = AppTheme.values[themeIndex];
    _applyTheme();
  }

  void _applyTheme() {
    switch (_currentTheme) {
      case AppTheme.Light:
        _themeData = ThemeData.light();
        break;
      case AppTheme.Dark:
        _themeData = ThemeData.dark();
        break;
    }
    notifyListeners();
  }

  void toggleTheme() {
    _currentTheme =
    _currentTheme == AppTheme.Light ? AppTheme.Dark : AppTheme.Light;
    _applyTheme();
    _saveThemePreference();
  }

  void _saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', _currentTheme.index);
  }
}