import 'package:clean_architecture/app/data/weather/source/local/db_weather_table.dart';
import 'package:clean_architecture/app/domain/weather/model/weather_request_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source.dart';
import 'package:clean_architecture/app/domain/weather/repository/weather_repository.dart';
import 'package:clean_architecture/core/network/service/network_service.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _weatherRemoteDataSource;
  final NetworkService _networkService;
  final DBWeatherTable _dbWeatherTable;

  const WeatherRepositoryImpl({
    required WeatherRemoteDataSource weatherRemoteDataSource,
    required NetworkService networkService,
    required DBWeatherTable dbWeatherTable,
  })  : _weatherRemoteDataSource = weatherRemoteDataSource,
        _networkService = networkService,
        _dbWeatherTable = dbWeatherTable;

  @override
  Future<AllWeatherInfoDTO?> getAllWeatherInfo({required WeatherRequestDTO weatherRequestDTO}) async {
    final AllWeatherInfoDTO? allWeatherInfoDTO;

    if (_networkService.isOnline()) {
      allWeatherInfoDTO = await _weatherRemoteDataSource.getAllWeatherInfo(weatherRequestDTO: weatherRequestDTO);
      await _dbWeatherTable.saveWeather(allWeatherInfoDTO: allWeatherInfoDTO);
    } else {
      allWeatherInfoDTO = await _dbWeatherTable.getAllWeatherInfo();
    }

    return allWeatherInfoDTO;
  }
}
