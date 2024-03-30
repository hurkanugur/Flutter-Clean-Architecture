import 'package:clean_architecture/config/app_resources.dart';
import 'package:clean_architecture/app/domain/weather/model/weather_request_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/data/weather/source/remote/weather_remote_data_source.dart';
import 'package:clean_architecture/core/error/enum/server/server_exception_type.dart';
import 'package:clean_architecture/core/error/enum/server_problem/unknown_problem_type.dart';
import 'package:clean_architecture/core/error/model/server_failure.dart';
import 'package:clean_architecture/core/api/service/http_service.dart';
import 'package:dio/dio.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final HttpService _httpService;

  const WeatherRemoteDataSourceImpl({
    required HttpService httpService,
  }) : _httpService = httpService;

  @override
  Future<AllWeatherInfoDTO> getAllWeatherInfo({required WeatherRequestDTO weatherRequestDTO}) async {
    const String url = '${AppResources.baseUrl}/weather?';

    final Map<String, dynamic> queryParameters = weatherRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.getRequest(
      url: url,
      queryParameters: queryParameters,
    );

    if (response.statusCode != 200) {
      throw ServerFailure.createAndLogFromResponseData(
        response: response,
        stackTrace: StackTrace.current,
      );
    }

    if (response.data == null) {
      throw ServerFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: null,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.nullResponseValueError,
        statusCode: null,
      );
    }

    return AllWeatherInfoDTO.fromJson(json: response.data);
  }
}
