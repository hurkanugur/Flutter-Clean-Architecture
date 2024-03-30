import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

enum UnknownProblemType {
  nullResponseValueError('NULL_RESPONSE_VALUE_ERROR'),
  unknownException('UNKNOWN_EXCEPTION');

  final String name;

  const UnknownProblemType(this.name);

  /// Creates a [UnknownProblemType] from [serverProblemName].
  ///
  /// Returns `null` when the enum is not found.
  static UnknownProblemType? findByName({required String? serverProblemName}) {
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
