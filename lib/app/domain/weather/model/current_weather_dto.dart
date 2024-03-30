import 'package:clean_architecture/app/domain/weather/enum/weather_condition_type.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:equatable/equatable.dart';

class CurrentWeatherDTO extends Equatable {
  final int? id;
  final String? main;
  final String? description;
  final WeatherConditionType? type;
  final String? iconCode;

  const CurrentWeatherDTO({
    required this.id,
    required this.main,
    required this.description,
    required this.type,
    required this.iconCode,
  });

  @override
  List<Object?> get props => [id, main, description, type];

  /// Creates a [CurrentWeatherDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory CurrentWeatherDTO.fromJson({required Map<String, dynamic> json}) {
    try {
      return CurrentWeatherDTO(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        type: WeatherConditionType.getWeatherConditionByCode(weatherConditionCode: json['id']),
        iconCode: json['icon'],
      );
    } on ClientFailure {
      rethrow;
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
        'id': id,
        'main': main,
        'description': description,
        'type': type?.weatherConditionCode,
        'icon': iconCode,
      };
    } on ClientFailure {
      rethrow;
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.serializationError,
      );
    }
  }
}
