import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadThemePreference();
  }

  // State
  AppThemeMode _themeMode = AppThemeMode.system;
  Color _primaryColor = const Color(0xFF6200EE);
  bool _useMaterial3 = true;
  double _textScaleFactor = 1.0;
  Locale _locale = const Locale('en', 'US');
  String _fontFamily = 'Roboto';

  // Preferences keys
  static const String _themeModeKey = 'theme_mode';
  static const String _primaryColorKey = 'primary_color';
  static const String _useMaterial3Key = 'use_material3';
  static const String _textScaleFactorKey = 'text_scale_factor';
  static const String _localeKey = 'locale';
  static const String _fontFamilyKey = 'font_family';

  // Getters
  AppThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;
  bool get useMaterial3 => _useMaterial3;
  double get textScaleFactor => _textScaleFactor;
  Locale get locale => _locale;
  String get fontFamily => _fontFamily;

  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  bool get isDarkMode {
    if (_themeMode == AppThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == AppThemeMode.dark;
  }

  bool get isLightMode => !isDarkMode;

  // Set theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    await _saveThemeMode();
    notifyListeners();
  }

  // Toggle theme mode (light/dark)
  Future<void> toggleTheme() async {
    if (_themeMode == AppThemeMode.light) {
      await setThemeMode(AppThemeMode.dark);
    } else if (_themeMode == AppThemeMode.dark) {
      await setThemeMode(AppThemeMode.light);
    } else {
      // If system, toggle to light or dark based on current system theme
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      await setThemeMode(
        brightness == Brightness.dark ? AppThemeMode.light : AppThemeMode.dark,
      );
    }
  }

  // Set primary color
  Future<void> setPrimaryColor(Color color) async {
    _primaryColor = color;
    await _savePrimaryColor();
    notifyListeners();
  }

  // Set Material 3 usage
  Future<void> setUseMaterial3(bool value) async {
    _useMaterial3 = value;
    await _saveUseMaterial3();
    notifyListeners();
  }

  // Set text scale factor
  Future<void> setTextScaleFactor(double factor) async {
    _textScaleFactor = factor.clamp(0.8, 1.5);
    await _saveTextScaleFactor();
    notifyListeners();
  }

  // Increase text size
  Future<void> increaseTextSize() async {
    await setTextScaleFactor(_textScaleFactor + 0.1);
  }

  // Decrease text size
  Future<void> decreaseTextSize() async {
    await setTextScaleFactor(_textScaleFactor - 0.1);
  }

  // Reset text size
  Future<void> resetTextSize() async {
    await setTextScaleFactor(1.0);
  }

  // Set locale
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _saveLocale();
    notifyListeners();
  }

  // Set font family
  Future<void> setFontFamily(String fontFamily) async {
    _fontFamily = fontFamily;
    await _saveFontFamily();
    notifyListeners();
  }

  // Predefined color schemes
  static const List<Color> predefinedColors = [
    Color(0xFF6200EE), // Purple
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFFF9800), // Orange
    Color(0xFFF44336), // Red
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF5722), // Deep Orange
    Color(0xFF795548), // Brown
    Color(0xFF607D8B), // Blue Grey
  ];

  // Get color scheme name
  String getColorSchemeName(Color color) {
    if (color == const Color(0xFF6200EE)) return 'Purple';
    if (color == const Color(0xFF2196F3)) return 'Blue';
    if (color == const Color(0xFF4CAF50)) return 'Green';
    if (color == const Color(0xFFFF9800)) return 'Orange';
    if (color == const Color(0xFFF44336)) return 'Red';
    if (color == const Color(0xFF9C27B0)) return 'Purple';
    if (color == const Color(0xFF00BCD4)) return 'Cyan';
    if (color == const Color(0xFFFF5722)) return 'Deep Orange';
    if (color == const Color(0xFF795548)) return 'Brown';
    if (color == const Color(0xFF607D8B)) return 'Blue Grey';
    return 'Custom';
  }

  // Predefined locales
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('es', 'ES'), // Spanish
    Locale('fr', 'FR'), // French
    Locale('de', 'DE'), // German
    Locale('it', 'IT'), // Italian
    Locale('pt', 'BR'), // Portuguese
    Locale('hi', 'IN'), // Hindi
    Locale('ar', 'SA'), // Arabic
    Locale('zh', 'CN'), // Chinese
    Locale('ja', 'JP'), // Japanese
  ];

  // Get locale name
  String getLocaleName(Locale locale) {
    if (locale == const Locale('en', 'US')) return 'English';
    if (locale == const Locale('es', 'ES')) return 'Español';
    if (locale == const Locale('fr', 'FR')) return 'Français';
    if (locale == const Locale('de', 'DE')) return 'Deutsch';
    if (locale == const Locale('it', 'IT')) return 'Italiano';
    if (locale == const Locale('pt', 'BR')) return 'Português';
    if (locale == const Locale('hi', 'IN')) return 'हिन्दी';
    if (locale == const Locale('ar', 'SA')) return 'العربية';
    if (locale == const Locale('zh', 'CN')) return '中文';
    if (locale == const Locale('ja', 'JP')) return '日本語';
    return 'Unknown';
  }

  // Predefined font families
  static const List<String> supportedFonts = [
    'Roboto',
    'Poppins',
    'Montserrat',
    'Open Sans',
    'Lato',
    'Raleway',
    'Ubuntu',
    'Nunito',
  ];

  // Reset to defaults
  Future<void> resetToDefaults() async {
    _themeMode = AppThemeMode.system;
    _primaryColor = const Color(0xFF6200EE);
    _useMaterial3 = true;
    _textScaleFactor = 1.0;
    _locale = const Locale('en', 'US');
    _fontFamily = 'Roboto';

    await _saveAllPreferences();
    notifyListeners();
  }

  // Private methods - Load preferences
  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load theme mode
      final themeModeIndex = prefs.getInt(_themeModeKey);
      if (themeModeIndex != null) {
        _themeMode = AppThemeMode.values[themeModeIndex];
      }

      // Load primary color
      final colorValue = prefs.getInt(_primaryColorKey);
      if (colorValue != null) {
        _primaryColor = Color(colorValue);
      }

      // Load Material 3 preference
      _useMaterial3 = prefs.getBool(_useMaterial3Key) ?? true;

      // Load text scale factor
      _textScaleFactor = prefs.getDouble(_textScaleFactorKey) ?? 1.0;

      // Load locale
      final localeString = prefs.getString(_localeKey);
      if (localeString != null) {
        final parts = localeString.split('_');
        if (parts.length == 2) {
          _locale = Locale(parts[0], parts[1]);
        }
      }

      // Load font family
      _fontFamily = prefs.getString(_fontFamilyKey) ?? 'Roboto';

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preferences: $e');
    }
  }

  // Save individual preferences
  Future<void> _saveThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeModeKey, _themeMode.index);
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  Future<void> _savePrimaryColor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_primaryColorKey, _primaryColor.value);
    } catch (e) {
      debugPrint('Error saving primary color: $e');
    }
  }

  Future<void> _saveUseMaterial3() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_useMaterial3Key, _useMaterial3);
    } catch (e) {
      debugPrint('Error saving Material 3 preference: $e');
    }
  }

  Future<void> _saveTextScaleFactor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_textScaleFactorKey, _textScaleFactor);
    } catch (e) {
      debugPrint('Error saving text scale factor: $e');
    }
  }

  Future<void> _saveLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _localeKey,
        '${_locale.languageCode}_${_locale.countryCode}',
      );
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }

  Future<void> _saveFontFamily() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_fontFamilyKey, _fontFamily);
    } catch (e) {
      debugPrint('Error saving font family: $e');
    }
  }

  Future<void> _saveAllPreferences() async {
    await _saveThemeMode();
    await _savePrimaryColor();
    await _saveUseMaterial3();
    await _saveTextScaleFactor();
    await _saveLocale();
    await _saveFontFamily();
  }
}
