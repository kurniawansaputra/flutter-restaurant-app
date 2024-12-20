import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preferences: $e');
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
        await prefs.setBool('isDarkMode', true);
      } else {
        _themeMode = ThemeMode.light;
        await prefs.setBool('isDarkMode', false);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling theme: $e');
    }
  }
}
