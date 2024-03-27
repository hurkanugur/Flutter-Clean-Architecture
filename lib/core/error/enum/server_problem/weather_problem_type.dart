import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

enum WeatherProblemType {
  regionError('REGION_ERROR'),
  languageError('LANGUAGE_ERROR');

  final String name;

  const WeatherProblemType(this.name);

  /// Creates a [WeatherProblemType] from [serverProblemName].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  static WeatherProblemType? findByName({required String? serverProblemName}) {
    if (serverProblemName == null || serverProblemName.isEmpty) {
      return null;
    }

    try {
      return values.firstWhere((element) => element.name == serverProblemName);
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }
}
