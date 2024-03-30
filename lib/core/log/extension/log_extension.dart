import 'dart:developer' as developer;
import 'package:clean_architecture/config/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/error/model/failure.dart';
import 'package:clean_architecture/core/error/model/server_failure.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';

extension LogExtension on StackTrace {
  /// Logs a success message.
  void printSuccessMessage({required TextType textType, dynamic data}) {
    if (!kDebugMode) {
      return;
    }

    final StackTrace currentStackTrace = this;

    final classAndMethodName = _findClassNameAndMethodNameFromStackTrace(currentStackTrace: currentStackTrace);

    String successMessage = AppStrings.emptyText;
    successMessage += '\n[ClassName]: ${classAndMethodName.$1}';
    successMessage += '\n[MethodName]: ${classAndMethodName.$2}';
    successMessage += '\n[DateTime]: ${DateTime.now()}';
    successMessage += '\n[Message]: $textType';
    successMessage += data == null ? '' : '\n[Data]: ${data?.toString() ?? AppStrings.emptyText}';

    developer.log(successMessage, name: 'SUCCESS', time: DateTime.now());
  }

  /// Logs an error message by [failure].
  void printErrorMessageByFailure({required Failure failure}) {
    if (!kDebugMode) {
      return;
    }

    final StackTrace currentStackTrace = this;

    final classAndMethodName = _findClassNameAndMethodNameFromStackTrace(currentStackTrace: currentStackTrace);

    String errorMessage = AppStrings.emptyText;
    errorMessage += '\n[ClassName]: ${classAndMethodName.$1}';
    errorMessage += '\n[MethodName]: ${classAndMethodName.$2}';
    errorMessage += '\n[DateTime]: ${DateTime.now()}';

    if (failure is ServerFailure) {
      errorMessage += '\n[StatusCode]: ${failure.statusCode ?? AppStrings.emptyText}';
      errorMessage += '\n[ServerExceptionType]: ${failure.serverExceptionType}';
      errorMessage += '\n[ServerProblemType]: ${failure.serverProblemType}';
    } else if (failure is ClientFailure) {
      errorMessage += '\n[ClientExceptionType]: ${failure.clientExceptionType}';
    }

    errorMessage += failure.exception == null ? '' : '\n[ErrorMessage]: ${failure.exception?.toString() ?? AppStrings.emptyText}';
    developer.log(errorMessage, name: 'FAILURE', time: DateTime.now());
  }

  /// Finds the class name and method name from the stack trace.
  (String, String) _findClassNameAndMethodNameFromStackTrace({required StackTrace currentStackTrace}) {
    final RegExp regex = RegExp(r'#\d+\s+(.*?)\s+\(');
    final Match? match = regex.firstMatch(currentStackTrace.toString());

    String className = AppStrings.emptyText;
    String methodName = AppStrings.emptyText;

    if (match != null && match.groupCount >= 1) {
      final String? classAndMethodName = match.group(1);

      if (classAndMethodName != null) {
        final List<String> parts = classAndMethodName.split('.');
        if (parts.length >= 2) {
          className = parts[0];
          methodName = parts[1];
        }
      }
    }

    return (className, methodName);
  }
}
