import 'package:flutter/material.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/localization/enum/language_type.dart';

extension TimeOfDayExtension on TimeOfDay {
  /// Converts a 24h format time string to [TimeOfDay].
  ///
  /// The [timeString] should be like 14:43 or like 01:14
  static TimeOfDay convert24hTimeStringToTimeOfDay({required String timeString}) {
    try {
      final int hour = int.parse(timeString.split(":")[0]);
      final int minute = int.parse(timeString.split(":")[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return const TimeOfDay(hour: 0, minute: 0);
  }

  /// Converts the [TimeOfDay] to String.
  ///
  /// If [forceTo24hFormat] = false and [languageType] is English, it will return a string in 12 AM/PM format.
  ///
  /// Otherwise it will return a string in 24h format.
  ///
  /// If [forceTo24hFormat] = true, it will always return a string in 12 AM/PM format.
  ///
  /// `Example`: 13:46 or 1:46 PM
  String convertTimeOfDayToString({
    required LanguageType languageType,
    required bool forceTo24hFormat,
  }) {
    if ((languageType == LanguageType.english) && !forceTo24hFormat) {
      return '${hourOfPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${period.name.toUpperCase()}';
    } else {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }
}
