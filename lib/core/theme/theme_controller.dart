import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeController extends ChangeNotifier {
  AppThemeType _currentTheme = AppThemeType.pink;
  
  AppThemeType get currentTheme => _currentTheme;
  AppThemePalette get palette => AppThemePalette.getPalette(_currentTheme);

  void setTheme(AppThemeType type) {
    if (_currentTheme == type) return;
    _currentTheme = type;
    notifyListeners();
  }

  void cycleTheme() {
    final nextIndex = (_currentTheme.index + 1) % AppThemeType.values.length;
    setTheme(AppThemeType.values[nextIndex]);
  }
}