import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

enum UnknownProblemType {
  nullResponseValueError('NULL_RESPONSE_VALUE_ERROR'),
  unknownException('UNKNOWN_EXCEPTION');

  final String name;

  const UnknownProblemType(this.name);

  /// Creates a [UnknownProblemType] from [serverProblemName].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  static UnknownProblemType? findByName({required String? serverProblemName}) {
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
