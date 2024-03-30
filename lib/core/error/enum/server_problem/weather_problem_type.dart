import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

enum WeatherProblemType {
  regionError('REGION_ERROR'),
  languageError('LANGUAGE_ERROR');

  final String name;

  const WeatherProblemType(this.name);

  /// Creates a [WeatherProblemType] from [serverProblemName].
  ///
  /// Returns `null` when the enum is not found.
  static WeatherProblemType? findByName({required String? serverProblemName}) {
    try {
      return values.firstWhere((element) => element.name == serverProblemName);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }
}
