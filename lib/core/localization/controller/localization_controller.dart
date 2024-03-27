import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/localization/enum/language_type.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/error/model/failure.dart';
import 'package:clean_architecture/core/error/model/server_failure.dart';

class LocalizationState {
  final LanguageType languageType;
  final Map<String, dynamic> translations;

  const LocalizationState({
    required this.translations,
    required this.languageType,
  });

  /// Creates a copy of this class.
  LocalizationState copyWith({
    LanguageType? languageType,
    Map<String, dynamic>? translations,
  }) {
    return LocalizationState(
      languageType: languageType ?? this.languageType,
      translations: translations ?? this.translations,
    );
  }
}

class LocalizationController extends StateNotifier<LocalizationState> {
  LocalizationController()
      : super(
          const LocalizationState(
            languageType: LanguageType.english,
            translations: {},
          ),
        );

  /// Getter for [languageType].
  LanguageType get languageType => state.languageType;

  /// Changes the language of the app.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Future<void> changeLanguage({required LanguageType languageType}) async {
    try {
      final String translationJsonString = await rootBundle.loadString(languageType.translationFilePath);
      state = LocalizationState(
        languageType: languageType,
        translations: json.decode(translationJsonString),
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.translationUpdateError,
      );
    }
  }

  /// Translates the given [TextType].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  String translateText({required TextType textType}) {
    try {
      return state.translations['APPLICATION_TEXT']![textType.name];
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.translationNotFoundError,
      );
    }
  }

  /// Translates the given [Failure].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  String translateFailure({required Failure failure}) {
    try {
      if (failure is ServerFailure) {
        return state.translations['SERVER_EXCEPTION']![failure.serverExceptionType.name][failure.serverProblemType.name];
      } else if (failure is ClientFailure) {
        return state.translations['CLIENT_EXCEPTION']![failure.clientExceptionType.name];
      }
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.translationNotFoundError,
      );
    }

    throw ClientFailure(
      stackTrace: StackTrace.current,
      thrownErrorOrException: null,
      clientExceptionType: ClientExceptionType.unexpectedFailureTypeError,
    );
  }
}
