import 'package:flutter/material.dart';
import 'package:musicboxd/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = true;

  ThemeData get currentTheme => isDarkMode ? AppTheme.darkTheme : ThemeData.light(); 

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}