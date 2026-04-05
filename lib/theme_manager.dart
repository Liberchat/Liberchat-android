import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, auto }
enum AppColorTheme { red, blue, green, purple, orange, teal }

class ThemeManager extends ChangeNotifier {
  static const String _themeModeKey = 'theme_mode';
  static const String _colorThemeKey = 'color_theme';
  static const String _fontSizeKey = 'font_size';

  AppThemeMode _themeMode = AppThemeMode.auto;
  AppColorTheme _colorTheme = AppColorTheme.red;
  double _fontSize = 16.0;

  AppThemeMode get themeMode => _themeMode;
  AppColorTheme get colorTheme => _colorTheme;
  double get fontSize => _fontSize;

  // Couleurs pour chaque thème
  static const Map<AppColorTheme, Color> _primaryColors = {
    AppColorTheme.red: Colors.red,
    AppColorTheme.blue: Colors.blue,
    AppColorTheme.green: Colors.green,
    AppColorTheme.purple: Colors.purple,
    AppColorTheme.orange: Colors.orange,
    AppColorTheme.teal: Colors.teal,
  };

  static const Map<AppColorTheme, String> _colorNames = {
    AppColorTheme.red: 'Red',
    AppColorTheme.blue: 'Blue',
    AppColorTheme.green: 'Green',
    AppColorTheme.purple: 'Purple',
    AppColorTheme.orange: 'Orange',
    AppColorTheme.teal: 'Teal',
  };

  Color get primaryColor => _primaryColors[_colorTheme]!;
  String get colorName => _colorNames[_colorTheme]!;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Charger le mode de thème
    final themeModeIndex = prefs.getInt(_themeModeKey) ?? AppThemeMode.auto.index;
    _themeMode = AppThemeMode.values[themeModeIndex];
    
    // Charger le thème de couleur
    final colorThemeIndex = prefs.getInt(_colorThemeKey) ?? AppColorTheme.red.index;
    _colorTheme = AppColorTheme.values[colorThemeIndex];
    
    // Charger la taille de police
    _fontSize = prefs.getDouble(_fontSizeKey) ?? 16.0;
    
    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
    notifyListeners();
  }

  Future<void> setColorTheme(AppColorTheme theme) async {
    _colorTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorThemeKey, theme.index);
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, size);
    notifyListeners();
  }

  ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      fontFamily: 'Roboto',
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
        foregroundColor: primaryColor,
        elevation: 2,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      fontFamily: 'Roboto',
    );
  }

  TextTheme _buildTextTheme(Brightness brightness) {
    final baseColor = brightness == Brightness.light ? Colors.black87 : Colors.white70;
    
    return TextTheme(
      displayLarge: TextStyle(fontSize: _fontSize + 16, color: baseColor, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: _fontSize + 12, color: baseColor, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: _fontSize + 8, color: baseColor, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(fontSize: _fontSize + 6, color: baseColor, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontSize: _fontSize + 4, color: baseColor, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: _fontSize + 2, color: baseColor, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: _fontSize + 2, color: baseColor, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: _fontSize, color: baseColor, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: _fontSize - 2, color: baseColor, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: _fontSize, color: baseColor),
      bodyMedium: TextStyle(fontSize: _fontSize - 2, color: baseColor),
      bodySmall: TextStyle(fontSize: _fontSize - 4, color: baseColor),
      labelLarge: TextStyle(fontSize: _fontSize - 2, color: baseColor, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: _fontSize - 4, color: baseColor, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: _fontSize - 6, color: baseColor, fontWeight: FontWeight.w500),
    );
  }

  ThemeMode getThemeMode() {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.auto:
        return ThemeMode.system;
    }
  }
}