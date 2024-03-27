import 'package:clean_architecture/core/localization/enum/language_type.dart';
import 'package:flutter/material.dart';

class AppConfig {
  const AppConfig._();

  /// API key for the OpenWeatherMap API.
  static const String apiKey = ':::::KEY:::::';

  /// Default language type.
  static const LanguageType defaultLanguageType = LanguageType.turkish;

  /// Default theme mode.
  static const ThemeMode defaultThemeMode = ThemeMode.dark;
}
