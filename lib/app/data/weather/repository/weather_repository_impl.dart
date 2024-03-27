import 'package:clean_architecture/app/domain/weather/model/weather_request_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source.dart';
import 'package:clean_architecture/app/domain/weather/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _weatherRemoteDataSource;

  const WeatherRepositoryImpl({
    required WeatherRemoteDataSource weatherRemoteDataSource,
  }) : _weatherRemoteDataSource = weatherRemoteDataSource;

  @override
  Future<AllWeatherInfoDTO?> getAllWeatherInfo({required WeatherRequestDTO weatherRequestDTO}) async {
    return await _weatherRemoteDataSource.getAllWeatherInfo(weatherRequestDTO: weatherRequestDTO);
  }
}
