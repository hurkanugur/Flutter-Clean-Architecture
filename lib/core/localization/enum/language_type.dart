import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/config/app_resources.dart';
import 'package:flutter/material.dart';

enum LanguageType {
  english('ENGLISH', 'en', 'US', AppResources.englishTranslationFilePath),
  turkish('TURKISH', 'tr', 'TR', AppResources.turkishTranslationFilePath);

  final String name;

  final String languageCode;

  final String region;

  final String translationFilePath;

  const LanguageType(
    this.name,
    this.languageCode,
    this.region,
    this.translationFilePath,
  );

  /// Gets the locale associated with this language.
  Locale getLocale() => Locale(languageCode, region);

  /// Creates a [LanguageType] from [languageName].
  ///
  /// Throws [ClientFailure] when an error occurs.
  LanguageType? getLanguageByName({required String? languageName}) {
    if (languageName == null || languageName.isEmpty) {
      return null;
    }

    try {
      return values.firstWhere((element) => element.name == languageName);
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }
}
