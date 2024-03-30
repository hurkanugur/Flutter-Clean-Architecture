import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/app/domain/weather/model/general_weather_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/current_weather_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/current_wind_dto.dart';
import 'package:equatable/equatable.dart';

class AllWeatherInfoDTO extends Equatable {
  final List<CurrentWeatherDTO?>? weather;
  final GeneralWeatherDTO? main;
  final CurrentWindDTO? wind;
  final String? name;

  const AllWeatherInfoDTO({
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
  });

  @override
  List<Object?> get props => [weather, main, wind, name];

  /// Creates an [AllWeatherInfoDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory AllWeatherInfoDTO.fromJson({required Map<String, dynamic> json}) {
    try {
      return AllWeatherInfoDTO(
        weather: (json['weather'] as List<dynamic>?)?.map((e) => e == null ? null : CurrentWeatherDTO.fromJson(json: e)).toList(),
        main: json['main'] == null ? null : GeneralWeatherDTO.fromJson(json: json['main']),
        wind: json['wind'] == null ? null : CurrentWindDTO.fromJson(json: json['wind']),
        name: json['name'],
      );
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.deserializationError,
      );
    }
  }

  /// Converts the DTO to JSON.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Map<String, dynamic> toJson() {
    try {
      return {
        'weather': weather?.map((item) => (item)?.toJson()).toList(),
        'main': (main)?.toJson(),
        'wind': (wind)?.toJson(),
        'name': name,
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
