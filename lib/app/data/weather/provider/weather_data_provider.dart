import 'package:clean_architecture/app/data/weather/repository/weather_repository_impl.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source_impl.dart';
import 'package:clean_architecture/app/domain/weather/repository/weather_repository.dart';
import 'package:clean_architecture/core/api/provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDataProvider {
  const WeatherDataProvider._();

  // Repository Providers

  /// Provider for [WeatherRepository].
  static final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
    return WeatherRepositoryImpl(
      weatherRemoteDataSource: ref.watch(weatherRemoteDataSourceProvider),
    );
  });

  // Remote Data Source Providers

  /// Provider for [WeatherRemoteDataSource].
  static final weatherRemoteDataSourceProvider = Provider<WeatherRemoteDataSource>((ref) {
    return WeatherRemoteDataSourceImpl(
      httpService: ref.watch(ApiProvider.httpServiceProvider),
    );
  });
}
