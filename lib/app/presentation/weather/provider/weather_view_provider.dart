import 'package:clean_architecture/app/domain/weather/provider/weather_domain_provider.dart';
import 'package:clean_architecture/app/presentation/weather/controller/weather_view_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherViewProvider {
  const WeatherViewProvider._();

  /// Provider for [WeatherViewController].
  static final weatherViewControllerProvider = StateNotifierProvider<WeatherViewController, WeatherViewState>((ref) {
    return WeatherViewController(
      getAllWeatherInfoUsecase: ref.watch(WeatherDomainProvider.getAllWeatherInfoUsecaseProvider),
    );
  });
}
