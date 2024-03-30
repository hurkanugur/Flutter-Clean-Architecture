import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:equatable/equatable.dart';

class GeneralWeatherDTO extends Equatable {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  const GeneralWeatherDTO({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  @override
  List<Object?> get props => [temp, feelsLike, tempMin, tempMax, pressure, humidity, seaLevel, grndLevel];

  /// Creates a [GeneralWeatherDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory GeneralWeatherDTO.fromJson({required Map<String, dynamic> json}) {
    try {
      return GeneralWeatherDTO(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level'],
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
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
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
