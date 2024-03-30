import 'package:flutter/material.dart';
import 'package:clean_architecture/core/datetime/extension/time_of_day_extension.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/localization/enum/language_type.dart';

extension DateTimeExtensions on DateTime {
  /// Get [DateTime] from [String].
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: The [dateTimeString] will be converted according to the device's timezone.
  static DateTime? convertDateTimeStringToDateTime({String? dateTimeString}) {
    if (dateTimeString == null) {
      return null;
    }

    try {
      return DateTime.parse(dateTimeString).toLocal();
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.parseOperationError,
      );
    }

    return null;
  }

  /// Get readible [DateTime] from [timestamp] using [languageType].
  ///
  /// If [displayYearAsTwoDigits] = true, 2022 will be shown as 22.
  ///
  /// If [ignoreTheDateIfSameAsToday] = true, the date part will be `null`.
  ///
  /// `Example`: 10/02/1998, 10:24:59
  static String? fromTimestampToReadibleDateTimeString({
    required int? timestamp,
    required LanguageType languageType,
    String divider = '/',
    bool displayYearAsTwoDigits = false,
    bool ignoreTheDateIfSameAsToday = false,
    bool forceTo24hFormat = false,
  }) {
    if (timestamp == null) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(timestamp).toReadableDateTimeString(
      languageType: languageType,
      divider: divider,
      displayYearAsTwoDigits: displayYearAsTwoDigits,
      ignoreTheDateIfSameAsToday: ignoreTheDateIfSameAsToday,
      forceTo24hFormat: forceTo24hFormat,
    );
  }

  /// Get readible [DateTime] string using [languageType].
  ///
  /// If [displayYearAsTwoDigits] = true, 2022 will be shown as 22.
  ///
  /// If [ignoreTheDateIfSameAsToday] = true, the date part will be `null`.
  ///
  /// `Example`: 10/02/1998, 10:24:59
  String toReadableDateTimeString({
    required LanguageType languageType,
    String divider = '/',
    bool displayYearAsTwoDigits = false,
    bool ignoreTheDateIfSameAsToday = false,
    bool forceTo24hFormat = false,
  }) {
    final bool isToday = this.isToday();

    final String? date = (isToday && ignoreTheDateIfSameAsToday) ? null : toDateStringFormat(divider: divider, displayYearAsTwoDigits: displayYearAsTwoDigits);
    final String time = TimeOfDay.fromDateTime(this).convertTimeOfDayToString(languageType: languageType, forceTo24hFormat: forceTo24hFormat);

    return '$date, $time';
  }

  /// Checks if the DateTime represents today's date.
  bool isToday() {
    final DateTime today = DateTime.now();
    return day == today.day && month == today.month && year == today.year;
  }

  /// Convert [DateTime]'s date part to string format with [divider].
  ///
  /// `Example`: 10.02.1998 or 10/02/1998
  String toDateStringFormat({String divider = '.', bool displayYearAsTwoDigits = false}) {
    String day = this.day.toString().padLeft(2, '0');
    String month = this.month.toString().padLeft(2, '0');
    String year = displayYearAsTwoDigits ? this.year.toString().substring(2) : this.year.toString();
    return '$day$divider$month$divider$year';
  }

  /// Converts [DateTime] to YYYY-MM-dd format.
  ///
  /// `Example`: 1998-02-10
  String toYYYYMMDDFormat() {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  /// Converts [DateTime] to HH:mm:ss format.
  ///
  /// `Example`: 14:21:59
  String toHHMMSSFormat() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    final seconds = second.toString().padLeft(2, '0');

    return '$hour:$minutes:$seconds';
  }

  /// Converts [DateTime] to YYYYMMdd format.
  ///
  /// `Example`: 19981002
  String toYYYYMMdd() {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');

    return '$year$month$day';
  }

  /// Converts [DateTime] to YYYYMMddTHHmmss format.
  ///
  /// If [hasTime] = false, it will calculate the time as 00:00:00.
  ///
  /// `Example`: 19980210T102459 or 19980210T000000
  String toYYYYMMddTHHmmss({bool hasTime = true}) {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    final hour = (hasTime ? this.hour : 0).toString().padLeft(2, '0');
    final minute = (hasTime ? this.minute : 0).toString().padLeft(2, '0');
    final second = (hasTime ? this.second : 0).toString().padLeft(2, '0');

    return '$year$month${day}T$hour$minute$second';
  }

  /// This method is used to convert [DateTime] to YYYY-MM-ddTHH:00:00.000Z format.
  ///
  /// If [hasTime] = false, it will calculate the time as 00:00:00.000.
  /// If [useOffsetInsteadOfZ] = true, it will use +00:00 instead of Z.
  /// Note that "Z" and "+00:00" stand for GMT timezone or UTC timezone.
  String toYYYYMMddTHHmmssZ({
    bool hasTime = true,
    bool useOffsetInsteadOfZ = false,
  }) {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    final hour = this.hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    final seconds = second.toString().padLeft(2, '0');
    final milliseconds = millisecond.toString().padLeft(3, '0');

    if (hasTime) {
      if (useOffsetInsteadOfZ) {
        return '$year-$month-${day}T$hour:$minutes:$seconds.$milliseconds+00:00';
      } else {
        return '$year-$month-${day}T$hour:$minutes:$seconds.${milliseconds}Z';
      }
    } else {
      if (useOffsetInsteadOfZ) {
        return '$year-$month-${day}T00:00:00.000+00:00';
      } else {
        return '$year-$month-${day}T00:00:00.000Z';
      }
    }
  }

  /// Converts [DateTime] to YYYY,MM,dd,HH,mm,ss format.
  ///
  /// `Example`: 1998,02,10,14,25,59
  String convertDateTimeToCommaSaperatedYYYYMMddHHmmss() {
    final String year = this.year.toString().padLeft(4, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String day = this.day.toString().padLeft(2, '0');
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    final String second = this.second.toString().padLeft(2, '0');

    return '$year,$month,$day,$hour,$minute,$second';
  }
}
