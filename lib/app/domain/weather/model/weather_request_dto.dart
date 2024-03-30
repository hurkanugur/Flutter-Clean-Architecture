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
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.serializationError,
      );
    }
  }
}
