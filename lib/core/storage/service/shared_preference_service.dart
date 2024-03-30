import 'package:flutter/material.dart';
import 'package:clean_architecture/core/localization/enum/language_type.dart';
import 'package:clean_architecture/core/security/service/data_security_service.dart';
import 'package:clean_architecture/core/theme/extension/theme_mode_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_architecture/config/app_config.dart';

class SharedPreferenceService {
  static const String _encryptedUsernameKey = 'encrypted_username';
  static const String _languageTypeKey = 'language_type';
  static const String _themeTypeKey = 'theme_type';

  final SharedPreferences _sharedPreferences;
  final DataSecurityService _dataSecurityService;

  const SharedPreferenceService({
    required SharedPreferences sharedPreferences,
    required DataSecurityService dataSecurityService,
  })  : _sharedPreferences = sharedPreferences,
        _dataSecurityService = dataSecurityService;

  /// Setter for [_encryptedUsernameKey].
  Future<void> setEncryptedUsername({required String plaintextUsername}) async {
    final String? encryptedUsername = _dataSecurityService.encrypt(plainText: plaintextUsername);

    if (encryptedUsername == null) {
      await deleteFromSharedPreferences(deleteEncryptedUsername: true);
    } else {
      await _sharedPreferences.setString(_encryptedUsernameKey, encryptedUsername);
    }
  }

  /// Getter for [_encryptedUsernameKey].
  String getPlaintextUsername() {
    final String? encryptedUsername = _sharedPreferences.getString(_encryptedUsernameKey);

    if (encryptedUsername == null) {
      return AppConfig.defaultUsername;
    }

    final String? plaintextUsername = _dataSecurityService.decrypt(chiperText: encryptedUsername);
    return plaintextUsername ?? AppConfig.defaultUsername;
  }

  /// Setter for [_languageTypeKey].
  Future<void> setLanguageType({required LanguageType languageType}) async {
    await _sharedPreferences.setInt(_languageTypeKey, languageType.index);
  }

  /// Getter for [_languageTypeKey].
  LanguageType getLanguageType() {
    final int? index = _sharedPreferences.getInt(_languageTypeKey);
    return LanguageType.getLanguageByIndex(index: index) ?? AppConfig.defaultLanguageType;
  }

  /// Setter for [_themeTypeKey].
  Future<void> setThemeMode({required ThemeMode themeMode}) async {
    await _sharedPreferences.setInt(_themeTypeKey, themeMode.index);
  }

  /// Getter for [_themeTypeKey].
  ThemeMode getThemeMode() {
    final int? index = _sharedPreferences.getInt(_themeTypeKey);
    return ThemeModeExtension.getThemeByIndex(index: index) ?? AppConfig.defaultThemeMode;
  }

  /// Deletes a key from the [_sharedPreferences].
  ///
  /// When [deleteALL] is `true`, it clears all key-value pairs from the [_sharedPreferences].
  Future<void> deleteFromSharedPreferences({
    bool deleteALL = false,
    bool deleteEncryptedUsername = false,
    bool deleteLanguageType = false,
    bool deleteThemeType = false,
  }) async {
    if (deleteALL == true) {
      await _sharedPreferences.clear();
      return;
    }

    if (deleteEncryptedUsername == true) {
      await _sharedPreferences.remove(_encryptedUsernameKey);
    }

    if (deleteLanguageType == true) {
      await _sharedPreferences.remove(_languageTypeKey);
    }

    if (deleteThemeType == true) {
      await _sharedPreferences.remove(_themeTypeKey);
    }
  }
}
