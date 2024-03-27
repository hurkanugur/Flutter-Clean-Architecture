import 'package:clean_architecture/app/data/weather/provider/weather_data_provider.dart';
import 'package:clean_architecture/app/domain/weather/usecase/get_all_weather_info_usecase.dart';
import 'package:clean_architecture/app/domain/weather/usecase/get_all_weather_info_usecase_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDomainProvider {
  const WeatherDomainProvider._();

  /// Provider for [GetAllWeatherInfoUsecase].
  static final getAllWeatherInfoUsecaseProvider = Provider<GetAllWeatherInfoUsecase>((ref) {
    return GetAllWeatherInfoUsecaseImpl(
      weatherRepository: ref.watch(WeatherDataProvider.weatherRepositoryProvider),
    );
  });
}
