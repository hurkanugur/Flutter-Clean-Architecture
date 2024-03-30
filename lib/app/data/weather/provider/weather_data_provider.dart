import 'package:clean_architecture/app/data/auth/provider/auth_provider.dart';
import 'package:clean_architecture/app/data/weather/repository/weather_repository_impl.dart';
import 'package:clean_architecture/app/data/weather/source/local/db_weather_table.dart';
import 'package:clean_architecture/app/data/weather/source/local/db_weather_table_impl.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source_impl.dart';
import 'package:clean_architecture/app/domain/weather/repository/weather_repository.dart';
import 'package:clean_architecture/core/api/provider/api_provider.dart';
import 'package:clean_architecture/core/directory/provider/directory_provider.dart';
import 'package:clean_architecture/core/network/provider/network_provider.dart';
import 'package:clean_architecture/core/security/provider/security_provider.dart';
import 'package:clean_architecture/core/storage/provider/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDataProvider {
  const WeatherDataProvider._();

  // Repository Providers

  /// Provider for [WeatherRepository].
  static final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
    return WeatherRepositoryImpl(
      weatherRemoteDataSource: ref.watch(weatherRemoteDataSourceProvider),
      dbWeatherTable: ref.watch(dbWeatherTableProvider),
      networkService: ref.watch(NetworkProvider.networkServiceProvider),
    );
  });

  // Remote Data Source Providers

  /// Provider for [WeatherRemoteDataSource].
  static final weatherRemoteDataSourceProvider = Provider<WeatherRemoteDataSource>((ref) {
    return WeatherRemoteDataSourceImpl(
      httpService: ref.watch(ApiProvider.httpServiceProvider),
    );
  });

  // Local Data Source Providers

  /// Provider for [DBWeatherTable].
  static final dbWeatherTableProvider = Provider<DBWeatherTable>((ref) {
    return DBWeatherTableImpl(
      dataSecurityService: ref.watch(SecurityProvider.dataSecurityServiceProvider),
      databaseService: ref.watch(StorageProvider.databaseServiceProvider),
      dbUserTable: ref.watch(AuthProvider.dbUserTableProvider),
      directoryService: ref.watch(DirectoryProvider.directoryServiceProvider),
      sharedPreferenceService: ref.watch(StorageProvider.sharedPreferenceServiceProvider),
    );
  });
}
