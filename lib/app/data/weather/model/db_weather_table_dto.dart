import 'package:clean_architecture/app/data/weather/source/local/db_weather_table.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:equatable/equatable.dart';

class DBWeatherTableDTO extends Equatable {
  final String weatherContentExternalFileName;
  final int userId;

  const DBWeatherTableDTO({
    required this.weatherContentExternalFileName,
    required this.userId,
  });

  @override
  List<Object?> get props => [weatherContentExternalFileName, userId];

  factory DBWeatherTableDTO.fromJson({required Map<String, Object?> json}) {
    try {
      return DBWeatherTableDTO(
        weatherContentExternalFileName: json[DBWeatherTable.weatherContentExternalFileName] as String,
        userId: json[DBWeatherTable.userId] as int,
      );
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.deserializationError,
      );
    }
  }

  Map<String, Object?> toJson() {
    try {
      return {
        DBWeatherTable.weatherContentExternalFileName: weatherContentExternalFileName,
        DBWeatherTable.userId: userId,
      };
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.serializationError,
      );
    }
  }
}
