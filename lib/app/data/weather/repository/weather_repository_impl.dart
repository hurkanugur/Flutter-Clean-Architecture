import 'package:clean_architecture/app/data/weather/source/local/db_weather_table.dart';
import 'package:clean_architecture/app/domain/weather/model/weather_request_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source.dart';
import 'package:clean_architecture/app/domain/weather/repository/weather_repository.dart';
import 'package:clean_architecture/core/base/model/operation_result.dart';
import 'package:clean_architecture/core/error/model/failure.dart';
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
  Future<OperationResult<AllWeatherInfoDTO?>> getAllWeatherInfo({required WeatherRequestDTO weatherRequestDTO}) async {
    final AllWeatherInfoDTO? allWeatherInfoDTO;

    try {
      if (_networkService.isOnline()) {
        allWeatherInfoDTO = await _weatherRemoteDataSource.getAllWeatherInfo(weatherRequestDTO: weatherRequestDTO);
        await _dbWeatherTable.saveWeather(allWeatherInfoDTO: allWeatherInfoDTO);
      } else {
        allWeatherInfoDTO = await _dbWeatherTable.getAllWeatherInfo();
      }
    } on Failure catch (ex) {
      return OperationResult<AllWeatherInfoDTO?>(data: null, failures: [ex]);
    }

    return OperationResult<AllWeatherInfoDTO?>(data: allWeatherInfoDTO, failures: null);
  }
}
