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
  /// Returns `null` when the enum is not found.
  static LanguageType? getLanguageByName({required String? languageName}) {
    try {
      return values.firstWhere((element) => element.name == languageName);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }

  /// Creates a [LanguageType] from [index].
  ///
  /// Returns `null` when the enum is not found.
  static LanguageType? getLanguageByIndex({required int? index}) {
    try {
      return values.firstWhere((element) => element.index == index);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }
}
