import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/enum/server_problem/dio_problem_type.dart';
import 'package:clean_architecture/core/error/enum/server_problem/unknown_problem_type.dart';
import 'package:clean_architecture/core/error/enum/server_problem/weather_problem_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:dio/dio.dart';

enum ServerExceptionType {
  dioException('DIO_EXCEPTION', DioProblemType.values),
  weatherException('WEATHER_EXCEPTION', WeatherProblemType.values),
  unknownException('UNKNOWN_EXCEPTION', UnknownProblemType.values);

  final String name;

  final List<Enum> problemTypes;

  const ServerExceptionType(this.name, this.problemTypes);

  /// Creates a [ServerExceptionType] from [serverExceptionName].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  static ServerExceptionType? getServerExceptionByName({required String? serverExceptionName}) {
    if (serverExceptionName == null || serverExceptionName.isEmpty) {
      return null;
    }

    try {
      return values.firstWhere((element) => element.name == serverExceptionName);
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }

  /// Retrieves a problem type by its name.
  ///
  /// Throws [ClientFailure] when the type does not exist.
  Enum? getProblemByName({required String? serverProblemName}) {
    if (serverProblemName == null || serverProblemName.isEmpty) {
      return null;
    }

    try {
      return switch (this) {
        ServerExceptionType.dioException => DioExceptionType.values.firstWhere((element) => element.name == serverProblemName, orElse: () => DioExceptionType.unknown),
        ServerExceptionType.weatherException => WeatherProblemType.findByName(serverProblemName: serverProblemName),
        ServerExceptionType.unknownException => UnknownProblemType.findByName(serverProblemName: serverProblemName),
      };
    } on ClientFailure {
      rethrow;
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }
}
