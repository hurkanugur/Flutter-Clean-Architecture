import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/weather_request_dto.dart';
import 'package:clean_architecture/app/domain/weather/repository/weather_repository.dart';
import 'package:clean_architecture/app/domain/weather/usecase/get_all_weather_info_usecase.dart';
import 'package:clean_architecture/core/base/model/operation_result.dart';

class GetAllWeatherInfoUsecaseImpl implements GetAllWeatherInfoUsecase {
  final WeatherRepository _weatherRepository;

  const GetAllWeatherInfoUsecaseImpl({
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  @override
  Future<OperationResult<AllWeatherInfoDTO?>> execute({required WeatherRequestDTO weatherRequestDTO}) async {
    return await _weatherRepository.getAllWeatherInfo(weatherRequestDTO: weatherRequestDTO);
  }
}
