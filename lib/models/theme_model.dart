import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _fontFamily = 'HarmonyOS Sans SC';

  String get fontFamily => _fontFamily;
  ThemeMode get themeMode => _themeMode;

  ThemeModel() {
    // Theme is loaded manually via loadTheme() to allow awaiting
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    _saveTheme();
    notifyListeners();
  }

  void setFontFamily(String family) {
    _fontFamily = family;
    _saveTheme();
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_mode');
    if (themeIndex != null) {
      _themeMode = ThemeMode.values[themeIndex];
    }
    
    String? savedFont = prefs.getString('font_family');
    // If the saved font is 'Google Sans' or is not in our current list, reset to default
    const supportedFonts = ['HarmonyOS Sans SC', 'MiSans', 'Gakumas Font'];
    if (savedFont == null || !supportedFonts.contains(savedFont)) {
      _fontFamily = 'HarmonyOS Sans SC';
    } else {
      _fontFamily = savedFont;
    }
    
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', _themeMode.index);
    await prefs.setString('font_family', _fontFamily);
  }
}
