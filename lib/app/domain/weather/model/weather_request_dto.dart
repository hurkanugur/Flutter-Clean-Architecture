import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:equatable/equatable.dart';

class WeatherRequestDTO extends Equatable {
  final double latitude;
  final double longitude;
  final String languageCode;
  final String units;
  final String apiKey;

  const WeatherRequestDTO({
    required this.latitude,
    required this.longitude,
    required this.languageCode,
    required this.units,
    required this.apiKey,
  });

  @override
  List<Object?> get props => [latitude, longitude, languageCode, units, apiKey];

  /// Creates a [WeatherRequestDTO] from [weatherRequestDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory WeatherRequestDTO.fromDTO({required WeatherRequestDTO weatherRequestDTO}) {
    try {
      return WeatherRequestDTO(
        latitude: weatherRequestDTO.latitude,
        longitude: weatherRequestDTO.longitude,
        languageCode: weatherRequestDTO.languageCode,
        units: weatherRequestDTO.units,
        apiKey: weatherRequestDTO.apiKey,
      );
    } on ClientFailure {
      rethrow;
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
      );
    }
  }

  /// Converts the DTO to JSON.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Map<String, dynamic> toJson() {
    try {
      return {
        'lat': latitude,
        'lon': longitude,
        'lang': languageCode,
        'units': units,
        'appid': apiKey,
      };
    } on ClientFailure {
      rethrow;
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
      );
    }
  }
}
