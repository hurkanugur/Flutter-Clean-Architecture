import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/weather_request_dto.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/error/model/server_failure.dart';

abstract interface class GetAllWeatherInfoUsecase {
  /// Gell all weather information based on [weatherRequestDTO].
  ///
  /// Throws a [ServerFailure] or [ClientFailure] on failure.
  Future<AllWeatherInfoDTO?> execute({required WeatherRequestDTO weatherRequestDTO});
}
