import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/core/localization/enum/language_type.dart';

class SharedPreferenceService {
  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';

  final SharedPreferences _sharedPreferences;

  const SharedPreferenceService({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  /// Creates an instance of this class.
  static Future<SharedPreferenceService> createInstance() async {
    return SharedPreferenceService(
      sharedPreferences: await SharedPreferences.getInstance(),
    );
  }

  /// Setter for [_themeKey].
  Future<void> setTheme({required ThemeMode themeMode}) async {
    await _sharedPreferences.setInt(_themeKey, themeMode.index);
  }

  /// Getter for [_themeKey].
  ThemeMode getTheme() {
    final int? index = _sharedPreferences.getInt(_themeKey);

    return ThemeMode.values.firstWhere(
      (element) => element.index == index,
      orElse: () => AppConfig.defaultThemeMode,
    );
  }

  /// Setter for [_languageKey].
  Future<void> setLanguage({required LanguageType languageType}) async {
    await _sharedPreferences.setInt(_languageKey, languageType.index);
  }

  /// Getter for [_languageKey].
  LanguageType getLanguage() {
    final int? index = _sharedPreferences.getInt(_languageKey);

    return LanguageType.values.firstWhere(
      (element) => element.index == index,
      orElse: () => AppConfig.defaultLanguageType,
    );
  }

  /// Clears all key value pairs.
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
