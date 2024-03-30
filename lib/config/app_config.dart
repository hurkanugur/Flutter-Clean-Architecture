import 'package:clean_architecture/core/localization/enum/language_type.dart';
import 'package:clean_architecture/environment/model/flavor_config_model.dart';
import 'package:flutter/material.dart';

class AppConfig {
  const AppConfig._();

  /// Represents the active environment.
  static late final FlavorConfigModel environment;

  // TODO Replace with your API key
  /// API key for the OpenWeatherMap API.
  static const String apiKey = '9db5da2f43761af17da19bc3f2c12683';

  /// Default language type.
  static const String defaultUsername = 'example@example.com';

  /// Default language type.
  static const LanguageType defaultLanguageType = LanguageType.english;

  /// Default theme mode.
  static const ThemeMode defaultThemeMode = ThemeMode.system;
}
